//
//  CoworkingSpaceDao.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation

class CoworkingSpaceDao: RealmDao<CoworkingRealmEntity>,ListCoworkingSpaceCache {
    
    func createOrUpdate(listCoworking: [CoworkingModel]) throws  {
        for coworking in listCoworking {
            try self.createOrUpdate(ConvertCoworkingCacheManager
                .shared
                .convertModelToRealm(data: coworking)
            )
        }
    }
    
    func getListCoworking() throws -> [CoworkingModel] {
        var lisCoworking:[CoworkingModel] = []
        let listRealm = try self.findAll(CoworkingRealmEntity.self)?.toArray(ofType: CoworkingRealmEntity.self) ?? []
        for coworking in listRealm {
            lisCoworking.append(ConvertCoworkingCacheManager.shared
                .convertRealmToModel(realmData: coworking) ?? CoworkingModel())
        }
        return lisCoworking
    }
}
