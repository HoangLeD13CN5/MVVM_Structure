//
//  ListCoworkingViewModelTests.swift
//  MVVM_StructureTests
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import MVVM_Structure

class ListCoworkingViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_whenInitialized_storesInitParams() {
        let viewModel = ListCoworkingViewModel(coworkingRepos: CoworkingSpaceReposImpl())
        XCTAssertNotNil(viewModel.coworkingRepos)
    }
    
    func testGetListDataSuccess() {
       let asyncExpect = expectation(description: "fulfill test")
       let viewModel = ListCoworkingViewModel(coworkingRepos: CoworkingSpaceReposImpl())
        viewModel.loadDataAction
            .execute("Test")
            .subscribe(onNext: { _ in
                asyncExpect.fulfill()
            })
            .disposed(by: bag)
        waitForExpectations(timeout: 2.0, handler: nil )
        XCTAssertNotEqual(viewModel.listCoworking.value.count, 0)
    }
    
}

