//
//  CoworkingApiEntity.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import SwiftyJSON

class CoworkingApiEntity: ApiResult {
    var id:Int?
    var organization:OrganizationAPIEntity?
    var title:String?
    var description:String?
    var address:String?
    var contact:String?
    var location:String?
    var publish_status:Bool?
    var thumbnail:String?
    
    required init(_ json: JSON) {
        super.init(json)
        self.id = json["id"].intValue
        self.title = json["title"].string
        self.description = json["description"].string
        self.address = json["address"].string
        self.contact = json["contact"].string
        self.location = json["location"].string
        self.publish_status = json["publish_status"].bool
        self.thumbnail = json["thumbnail"].string
        self.organization = OrganizationAPIEntity(json["organization"])
    }
}
