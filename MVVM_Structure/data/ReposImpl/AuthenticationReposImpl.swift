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
    
    private let dao: LoginDao = LoginDao()
    
    func login(username: String, password: String) -> Observable<String> {
        return LoginAPI(username: username,password: password)
            .request()
            .flatMap { data in
                return self.setLocalOAuthToken(username: username, password: password, oauthToken: (data?.token))
            }
            .observeOn(MainScheduler.instance)
    }
    
    func logout() -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            do {
                try self.dao.delete()
                observer.onNext(true)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
    
    func getLocalOAuthToken() -> String {
        do {
            var token = try self.dao.getOAuthToken()
            if(token == nil) { token = "" }
            return token!
        } catch {
            print(error)
            return ""
        }
    }
    
    private func setLocalOAuthToken(username: String, password: String,oauthToken: String?) -> Observable<String> {
        return Observable<String>.create { observer in
            do {
                try self.dao.setOAuthToken(username:username,password:password,oauthToken: oauthToken ?? "")
                observer.onNext(oauthToken ?? "")
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
}
