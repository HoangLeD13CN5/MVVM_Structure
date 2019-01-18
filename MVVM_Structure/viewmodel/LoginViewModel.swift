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
    private(set) var email: BehaviorRelay<String> =  BehaviorRelay<String>(value: "")
    private(set) var password: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    private(set) var token: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private(set) var errorMessage: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private(set) var errorType: BehaviorRelay<LoginErrorType> = BehaviorRelay<LoginErrorType>(value: LoginErrorType.none)
    private(set) var isLoadingData = BehaviorRelay<Bool>(value: false)
    
    private(set) var loginAction: Action<String, String>!
    
    init(authRepos: AuthenticationRepos) {
        self.authRepos = authRepos
    }
    
    func login() {
        loginAction = Action { [weak self] sender in
            self?.isLoadingData.accept(true)
            guard let this = self else { return Observable.never() }
            return this.authRepos
                .login(username: this.email.value,password: this.password.value)
        }
        
        loginAction
            .elements
            .subscribe(onNext: { [weak self] (token) in
                self?.token.accept(token)
                self?.errorType.accept(LoginErrorType.none)
                self?.isLoadingData.accept(false)
            })
            .disposed(by: bag)
        
        loginAction
            .errors
            .subscribe(onNext: { [weak self] error in
                switch error {
                case .underlyingError(let apiError):
                    self?.isLoadingData.accept(false)
                    self?.errorType.accept(LoginErrorType.api)
                    self?.errorMessage.accept((apiError as NSError).domain)
                default:
                    break
                }
            })
            .disposed(by: bag)
    }
    
    func validateCredentials() -> Bool {
        guard email.value.validateEmailPattern() else {
            errorType.accept(LoginErrorType.email)
            errorMessage.accept("EMAIL_VALIDATE".localized)
            return false
        }
        
        guard password.value.validateLength(size: (8,15)) else{
            errorType.accept(LoginErrorType.password)
            errorMessage.accept("PASSWORD_VALIDATE".localized)
            return false
        }
        errorType.accept(LoginErrorType.none)
        errorMessage.accept("")
        return true
    }
}
