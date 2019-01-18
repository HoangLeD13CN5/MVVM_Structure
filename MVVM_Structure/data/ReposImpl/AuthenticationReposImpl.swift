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
    
    func login(username: String, password: String) -> Observable<String> {
        return LoginAPI(username: username,password: password)
            .request()
            .observeOn(MainScheduler.instance)
            .flatMap { data in
                return self.setLocalOAuthToken(oauthToken: (data?.token))
            }
        
    }
    
    func logout() -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            UserDefaultsApiManager.shared.saveToken(token: "")
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create {}
        }
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
