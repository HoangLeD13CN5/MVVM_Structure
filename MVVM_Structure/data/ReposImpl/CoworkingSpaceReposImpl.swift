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
    
    var dao:CoworkingSpaceDao
    
    init(dao:CoworkingSpaceDao) {
        self.dao = dao
    }
    
    func list(limit: Int, offset: Int) -> Observable<[CoworkingModel]> {
        return ListCoworkingSpaceAPI(limit: limit,offset: offset)
            .request()
            .flatMap{ data in
                return self.saveListCoworkingInCache(listCoworking: data)
            }
            .observeOn(MainScheduler.instance)
            .map { data in
                return data.map{ entity in
                    return ConvertCoworkingManager.shared.convertApiDataToModel(apiData: entity) ?? CoworkingModel()
                }
            }
            .catchError({ _ in
                return self.getListCoworkingInCache()
            })
    }
    
    private func saveListCoworkingInCache(listCoworking: [CoworkingApiEntity?]) -> Observable<[CoworkingApiEntity?]>{
        return Observable.deferred {[weak self] in
            guard let `self` = self else {
                return Observable.error(NSError(domain: "", code: -1, userInfo: nil))
            }
            for coworking in listCoworking {
                try self.dao.createOrUpdate(ConvertCoworkingManager
                    .shared
                    .convertApiDataToRealm(apiData: coworking)
                )
            }
            return Observable.just(listCoworking)
        }
    }
    
    private func getListCoworkingInCache() -> Observable<[CoworkingModel]>{
        return Observable.deferred {[weak self] in
            guard let `self` = self else {
                return Observable.error(NSError(domain: "", code: -1, userInfo: nil))
            }
            var lisCoworking:[CoworkingModel] = []
            let listRealm = try self.dao.findAll(CoworkingRealmEntity.self)?.toArray(ofType: CoworkingRealmEntity.self) ?? []
            for coworking in listRealm {
                lisCoworking.append(ConvertCoworkingManager.shared
                                                           .convertRealmToModel(realmData: coworking) ?? CoworkingModel())
            }
            return Observable.just(lisCoworking)
        }
    }
}
