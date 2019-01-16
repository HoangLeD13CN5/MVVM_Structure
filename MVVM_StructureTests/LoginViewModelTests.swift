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

@testable import MVVM_Structure

class LoginViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_whenInitialized_storesInitParams() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertNotNil(viewModel.authRepos)
    }
    
    func testLogin() {
        let asyncExpect = expectation(description: "fulfill test")
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.value = "lehoangd13cn5ptit@gmail.com.vn"
        viewModel.password.value = "H1234567"
        viewModel.login()
        viewModel.loginAction
            .execute("Test")
            .debug()
            .subscribe(onNext: { _ in
                asyncExpect.fulfill()
            })
            .disposed(by: bag)
        waitForExpectations(timeout: 2.0, handler: { error in
            XCTAssertEqual(viewModel.errorType.value.rawValue, LoginErrorType.api.rawValue)
            XCTAssertEqual(viewModel.token.value, "")
        })
    }
    
    func testPasswordValidate() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.value = "lehoangd13cn5ptit@gmail.com"
        viewModel.password.value = "H1234"
        XCTAssertEqual(viewModel.validateCredentials(),false)
        XCTAssertEqual(viewModel.errorType.value.rawValue, LoginErrorType.password.rawValue)
        
    }
    
    func testEmailValidate() {
        let viewModel = LoginViewModel(authRepos: AuthenticationReposImpl())
        XCTAssertEqual(viewModel.token.value, "")
        viewModel.email.value = "lehoangd13cn5ptit"
        viewModel.password.value = "H12345678"
        XCTAssertEqual(viewModel.validateCredentials(),false)
        XCTAssertEqual(viewModel.errorType.value.rawValue, LoginErrorType.email.rawValue)
    }
}
