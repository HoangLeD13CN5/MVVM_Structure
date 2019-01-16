//
//  APIService.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire
import SwiftyJSON

class ApiResult{
    required init(_ json: JSON) {
        
    }
}

class ApiErrorResult:Error{
    var message: String?
    var message_code: String?
    var message_params:String?
    
    init(_ val: Any) {
        let json = JSON(val)
        self.message = json["message_code"].string
    }
}

class APIService<T> {
    
     func request() -> Observable<T> {
        let manager = Alamofire.SessionManager.default
        
        return manager.rx
            .request(self.method(),
                     self.requestUrl(),
                     parameters: self.params(),
                     encoding: self.encoding(),
                     headers: self.headers())
            .flatMap { dataRequest -> Observable<DataResponse<Any>> in
                dataRequest
                    .rx.responseJSON()
            }
            .map { (dataResponse) -> T in
                return try self.process(dataResponse)
            }
    }
    
    private func process(_ response: DataResponse<Any>) throws -> T {
        let error: Error
        switch response.result {
        case .success(let value):
            if let statusCode = response.response?.statusCode , statusCode < 400 {
                return try! self.convertJson(JSON(data: response.data ?? Data()))
            } else {
                error = ApiErrorResult(value)
            }
        case .failure(let e):
            error = e
        }
        throw error
    }
    
    func convertJson(_ val: JSON?) throws -> T {
        throw NSError()
    }
    
    func requestUrl() -> String {
        return baseUrl() + path()
    }
    
    func baseUrl() -> String {
        return URLs.BASE_API
    }
    
    func path() -> String {
        fatalError("abstract method")
    }
    
    func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    func params() -> Parameters {
        return [:]
    }
    
    func encoding() -> Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    func headers() -> Alamofire.HTTPHeaders {
        return  ["Content-Type": "application/json"]
    }
}

