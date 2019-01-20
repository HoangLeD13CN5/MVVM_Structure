//
//  LoginAPI.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class LoginApiImpl: APIService<LoginEntity?>, LoginApi{
   
    var username: String = ""
    var password:String = ""
    
    func requestApi() -> Observable<String> {
        return request().flatMap { data in
            return self.setLocalOAuthToken(oauthToken: data?.token)
        }
    }
    
    func setParamater(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override func convertJson(_ val: JSON?) throws -> LoginEntity? {
        guard let value = val  else { return  nil }
        return LoginEntity(value)
    }
    
    override func path() -> String {
        return URLs.LOGIN
    }
    
    override func method() -> Alamofire.HTTPMethod {
        return .post
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func params() -> Parameters {
        return ["username" : self.username, "password" : self.password]
    }
    
    private func setLocalOAuthToken(oauthToken: String?) -> Observable<String> {
        return Observable<String>.create { observer in
            UserDefaultsApiManager.shared.saveToken(token: oauthToken ?? "")
            observer.onNext(oauthToken ?? "")
            observer.onCompleted()
            return Disposables.create {}
        }
    }
}


