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
    
    fileprivate var viewModel: LoginViewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bindUI()
        
    }
    
    private func bindUI() {
        viewModel.isLoadingData
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
        viewModel.errorMessage
            .asObservable()
            .bind(to: self.error.rx.text)
            .disposed(by: bag)
        username.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.viewModel.email.accept(self?.username.text ?? "")
                let _ = self?.viewModel.validateCredentials()
            })
            .disposed(by: bag)
        password.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.viewModel.password.accept(self?.password.text ?? "")
                let _ = self?.viewModel.validateCredentials()
            })
            .disposed(by: bag)
        self.btnLogin.rx.tap.do(onNext:  { [unowned self] in
            self.username.resignFirstResponder()
            self.password.resignFirstResponder()
        }).subscribe(onNext: {[weak self] _ in
                self?.viewModel.password.accept(self?.password.text ?? "")
                if self?.viewModel.validateCredentials() ?? false {
                    self?.viewModel.login()
                    self?.viewModel
                         .loginAction
                         .execute("Test")
                }
            })
            .disposed(by: bag)
        viewModel.token
            .asObservable()
            .bind(to: self.token.rx.text)
            .disposed(by: bag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }

}

