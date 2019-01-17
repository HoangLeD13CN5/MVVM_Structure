//
//  RlmLoginEntity.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/17/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RealmSwift

class RlmLoginEntity: Object, StandaloneCopy {
    @objc private dynamic var id: Int = 1
    
    @objc dynamic var username: String?
    @objc dynamic var password: String?
    @objc dynamic var oauthToken: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toStandalone() -> RlmLoginEntity {
        let ret = RlmLoginEntity()
        ret.username = self.username
        ret.password = self.password
        ret.oauthToken = self.oauthToken
        return ret
    }
}
