//
//  LoginDao.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/17/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RealmSwift

class LoginDao: RealmDao<RlmLoginEntity> {
    
    func getOAuthToken() throws -> String? {
        let data = try self.find(RlmLoginEntity.self)?.toStandalone()
        return data?.oauthToken
    }
    
    func setOAuthToken(username:String,password:String,oauthToken: String) throws {
        let realm = try Realm()
        var data = realm.objects(RlmLoginEntity.self).first
        if(data == nil) {
            data = RlmLoginEntity()
        }
        
        try realm.write {
            data?.oauthToken = oauthToken
        }
        
        try super.createOrUpdate(data!)
    }
}
