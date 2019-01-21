//
//  CoworkingSpaceReposImpl.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

class CoworkingSpaceReposImpl: CoworkingSpaceRepos{
    
    var dao:ListCoworkingSpaceCache
    var listCoworkingApi:ListCoworkingSpaceApi
    
    init(listCoworkingApi:ListCoworkingSpaceApi,dao:ListCoworkingSpaceCache) {
        self.listCoworkingApi = listCoworkingApi
        self.dao = dao
    }
    
    func list(limit: Int, offset: Int) -> Observable<[CoworkingModel]> {
        self.listCoworkingApi.setParamater(limit: limit, offset: offset)
        return self.listCoworkingApi
            .requestApi()
            .flatMap{ data in
                return self.saveListCoworkingInCache(listCoworking: data)
            }
            .catchError({ _ in
                return self.getListCoworkingInCache()
            })
            .observeOn(MainScheduler.instance)
    }
    
    private func saveListCoworkingInCache(listCoworking: [CoworkingModel]) -> Observable<[CoworkingModel]>{
        return Observable.deferred {[weak self] in
            guard let `self` = self else {
                return Observable.error(NSError(domain: "", code: -1, userInfo: nil))
            }
            try self.dao.createOrUpdate(listCoworking: listCoworking)
            return Observable.just(listCoworking)
        }
    }
    
    private func getListCoworkingInCache() -> Observable<[CoworkingModel]>{
        return Observable.deferred {[weak self] in
            guard let `self` = self else {
                return Observable.error(NSError(domain: "", code: -1, userInfo: nil))
            }
            let lisCoworking:[CoworkingModel] = try self.dao.getListCoworking()
            return Observable.just(lisCoworking)
        }
    }
}
