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
    private(set) var token: BehaviorRelay<[CoworkingModel]> = BehaviorRelay<[CoworkingModel]>(value: [])
    private(set) var errorMessage: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private(set) var isLoadingData = BehaviorRelay<Bool>(value: false)
    private(set) var listCoworkingAction: Action<String, [CoworkingModel]>!
    
    init(coworkingRepos: CoworkingSpaceRepos) {
        self.coworkingRepos = coworkingRepos
    }
    
}
