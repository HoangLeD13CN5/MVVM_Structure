//
//  ViewController.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/15/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    fileprivate let bag = DisposeBag()
    @IBOutlet weak var token: UILabel!
    @IBOutlet weak var loading: UILabel!
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bindUI()
    }
    
    private func bindUI() {
        loginViewModel.isLoadingData
            .asObservable()
            .map{ isLoading in
                if isLoading {
                    return "Loading"
                }else {
                    return "Loading done"
                }
            }
            .bind(to: self.loading.rx.text)
            .disposed(by: bag)
        loginViewModel.errorMessage
            .asObservable()
            .bind(to: self.error.rx.text)
            .disposed(by: bag)
        username.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.loginViewModel.email.accept(self?.username.text ?? "")
                let _ = self?.loginViewModel.validateCredentials()
            })
            .disposed(by: bag)
        password.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.loginViewModel.password.accept(self?.password.text ?? "")
                let _ = self?.loginViewModel.validateCredentials()
            })
            .disposed(by: bag)
        self.btnLogin.rx.tap.do(onNext:  { [unowned self] in
            self.username.resignFirstResponder()
            self.password.resignFirstResponder()
        }).subscribe(onNext: {[weak self] _ in
                self?.loginViewModel.password.accept(self?.password.text ?? "")
                if self?.loginViewModel.validateCredentials() ?? false {
                    self?.loginViewModel
                         .loginAction
                         .execute("Test")
                }
            })
            .disposed(by: bag)
        loginViewModel.token
            .asObservable()
            .bind(to: self.token.rx.text)
            .disposed(by: bag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }
}

