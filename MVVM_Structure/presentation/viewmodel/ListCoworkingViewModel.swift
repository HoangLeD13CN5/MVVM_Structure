//
//  ListCoworkingViewModel.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

class ListCoworkingViewModel {
    
    let coworkingRepos:CoworkingSpaceRepos!
    let bag = DisposeBag()
    // MARK: - Input
    private(set) var offset: BehaviorRelay<Int> =  BehaviorRelay<Int>(value: 0)
    
    // MARK: - Output
    private(set) var listCoworking: BehaviorRelay<[CoworkingModel]> = BehaviorRelay<[CoworkingModel]>(value: [])
    private(set) var errorMessage: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private(set) var isLoadingData = BehaviorRelay<Bool>(value: false)
    private(set) var loadDataAction: Action<String, [CoworkingModel]>!
    
    init(coworkingRepos: CoworkingSpaceRepos) {
        self.coworkingRepos = coworkingRepos
        self.bindOutput()
    }
    
    private func bindOutput() {
        loadDataAction = Action { [weak self] sender in
            print(sender)
            self?.isLoadingData.accept(true)
            guard let this = self else { return Observable.never() }
            return this.coworkingRepos.list(limit: 10, offset: this.offset.value)
        }
        
        loadDataAction
            .elements
            .subscribe(onNext: { [weak self] (coworkingList) in
                self?.listCoworking.accept(coworkingList)
                self?.isLoadingData.accept(false)
            })
            .disposed(by: bag)
        
        loadDataAction
            .errors
            .subscribe(onNext: { [weak self](error) in
                self?.isLoadingData.accept(false)
                print(error)
            })
            .disposed(by: bag)
    }
}
