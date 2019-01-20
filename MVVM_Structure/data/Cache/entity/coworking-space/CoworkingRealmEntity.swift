//
//  CoworkingRealmEntity.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RealmSwift

class CoworkingRealmEntity:Object,StandaloneCopy {
    typealias T = CoworkingRealmEntity
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var descriptionWorking: String?
    @objc dynamic var address: String?
    @objc dynamic var contact: String?
    @objc dynamic var location: String?
    @objc dynamic var publish_status: Bool = true
    @objc dynamic var thumbnail: String?
    
    @objc dynamic var idOrganization: Int = 0
    @objc dynamic var nameOrganization: String?
    @objc dynamic var addressOrganization: String?
    @objc dynamic var phoneNumberOrganization: String?
    
    // MARK: helper
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toStandalone() -> CoworkingRealmEntity {
        let ret = CoworkingRealmEntity()
        ret.id = self.id
        ret.title = self.title
        ret.descriptionWorking = self.descriptionWorking
        ret.address = self.address
        ret.contact = self.contact
        ret.location = self.location
        ret.publish_status = self.publish_status
        ret.thumbnail = self.thumbnail
        
        ret.idOrganization = self.idOrganization
        ret.nameOrganization = self.nameOrganization
        ret.addressOrganization = self.addressOrganization
        ret.phoneNumberOrganization = self.phoneNumberOrganization
        return ret
    }
}

