//
//  LoginViewModelTests.swift
//  MVVM_StructureTests
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import MVVM_Structure

class LoginViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    func test_whenInitialized_storesInitParams() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertNotNil(viewModel.authRepos)
    }
    
    func testLoginSuccess() {
        let asyncExpect = expectation(description: "fulfill test")
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.accept("lehoangd13cn5ptit")
        viewModel.password.accept("H1234567")
        viewModel.loginAction
            .execute("Test")
            .subscribe(onNext: { _ in
                asyncExpect.fulfill()
            })
            .disposed(by: bag)
        waitForExpectations(timeout: 2.0, handler: nil )
        XCTAssertNotEqual(viewModel.token.value, "")
    }
    
    func testLoginFailer(){
        
        let asyncExpect = expectation(description: "fulfill test")
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.accept("lehoangd13cn5ptit.gmail.com.vn")
        viewModel.password.accept("H1234567")
        viewModel.loginAction
            .errors
            .subscribe(onNext: { _ in
                asyncExpect.fulfill()
            })
            .disposed(by: bag)
        viewModel.loginAction.execute("Test")
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertEqual(viewModel.token.value, "")
    }
    
    func testPasswordValidate() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.accept("lehoangd13cn5ptit@gmail.com")
        viewModel.password.accept("H1234")
        XCTAssertEqual(viewModel.validateCredentials(),false)
        XCTAssertEqual(viewModel.errorType.value.rawValue, LoginErrorType.password.rawValue)
        
    }
    
    func testEmailValidate() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.accept("lehoangd13cn5ptit")
        viewModel.password.accept("H12345678")
        XCTAssertEqual(viewModel.validateCredentials(),false)
        XCTAssertEqual(viewModel.errorType.value.rawValue, LoginErrorType.email.rawValue)
    }
}
