//
//  AuthenticationReposImpl.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

class AuthenticationReposImpl: AuthenticationRepos{
    var loginApi:LoginApi
    
    init(loginApi:LoginApi) {
        self.loginApi = loginApi
    }
    
    func login(username: String, password: String) -> Observable<String> {
        self.loginApi.setParamater(username: username, password: password)
        return self.loginApi
                   .requestApi()
                   .observeOn(MainScheduler.instance)
    }
    
    func logout() -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            UserDefaultsApiManager.shared.saveToken(token: "")
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
}
