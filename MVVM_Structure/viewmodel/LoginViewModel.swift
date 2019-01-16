//
//  LoginModel.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import RxSwift
import RxCocoa
import Action
enum LoginErrorType:Int {
    case email
    case password
    case api
    case none
}
class LoginViewModel {
    
    let authRepos:AuthenticationRepos!
    let bag = DisposeBag()
    
    // MARK: - Input
    private(set) var email: Variable<String> = Variable("")
    private(set) var password: Variable<String> = Variable("")
    
    // MARK: - Output
    private(set) var token: Variable<String> = Variable("")
    private(set) var errorMessage: Variable<String> = Variable("")
    private(set) var errorType: Variable<LoginErrorType> = Variable(LoginErrorType.none)
    private(set) var isLoadingData = Variable(false)
    
    private(set) var loginAction: Action<String, String>!
    
    init(authRepos: AuthenticationRepos) {
        self.authRepos = authRepos
    }
    
    func login() {
        loginAction = Action { [weak self] sender in
            print(sender)
            self?.isLoadingData.value = true
            guard let this = self else { return Observable.never() }
            return this.authRepos
                .login(username: this.email.value,password: this.password.value)
        }
        
        loginAction
            .elements
            .subscribe(onNext: { [weak self] (token) in
                self?.token.value = token
                print(token)
                self?.isLoadingData.value = false
            })
            .disposed(by: bag)
        
        loginAction
            .errors
            .subscribe(onError: { [weak self](error) in
                self?.isLoadingData.value = false
                self?.errorType.value = LoginErrorType.api
                self?.errorMessage.value = (error as NSError).domain
                print(error)
            })
            .disposed(by: bag)
    }
    
    func validateCredentials() -> Bool {
        
        guard email.value.validateEmailPattern() else {
            errorType.value = LoginErrorType.email
            errorMessage.value = "EMAIL_VALIDATE".localized
            return false
        }
        
        guard password.value.validateLength(size: (8,15)) else{
            errorType.value = LoginErrorType.password
            errorMessage.value = "PASSWORD_VALIDATE".localized
            return false
        }
        
        errorMessage.value = ""
        return true
    }
}
