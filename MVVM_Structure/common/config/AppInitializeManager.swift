//
//  AppInitializeManager.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//  File Configutation App

import Foundation
import RxSwift

class AppInitializeManager {
    
    static let instance = AppInitializeManager()
    
    var initialized = false
    private let disposeBag = DisposeBag()
    
    private init() {
    }
    
    func prepare(_ application: UIApplication, callback:@escaping () -> Void) {
            initRealm()
            .subscribe(
                onSuccess: {[weak self] _ in
                    self?.initialized = true
                    callback()
                },
                onError: {[weak self] _ in
                    self?.initialized = false
                })
            .disposed(by: disposeBag)
        
    }
    
    func initRealm() -> Single<Bool>{
        return Single<Bool>.create { observer in
            RealmDao.realmInit()
            observer(.success(true))
            return Disposables.create()
        }
    }
}
