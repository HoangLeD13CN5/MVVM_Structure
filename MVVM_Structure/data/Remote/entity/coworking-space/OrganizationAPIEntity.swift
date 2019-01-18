//
//  OrganizationAPIEntity.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import SwiftyJSON

class OrganizationAPIEntity: ApiResult {
    var id:Int?
    var name:String?
    var address:String?
    var phoneNumber:String?
    
    required init(_ json: JSON) {
        super.init(json)
        self.id = json["id"].intValue
        self.name = json["name"].string
        self.address = json["address"].string
        self.phoneNumber = json["phone_number"].string
    }
}
