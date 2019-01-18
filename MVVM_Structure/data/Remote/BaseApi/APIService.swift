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
            if let statusCode = response.response?.statusCode , statusCode < 300 {
                return try! self.convertJson(JSON(data: response.data ?? Data()))
            } else {
                error = self.createError(value)
            }
        case .failure(let e):
            error = e
        }
        throw error
    }
    
    private func createError(_ val: Any) -> Error {
        let json = JSON(val)
        let message_code = json["message_code"].intValue
        let message = ""
        return NSError(domain: message, code:message_code, userInfo:nil)
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
        if (!UserDefaultsApiManager.shared.getToken().elementsEqual("")) {
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer " + UserDefaultsApiManager.shared.getToken()
            ]
        }
        return  ["Content-Type": "application/json"]
    }
}

