//
//  LoginEntity.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginEntity: ApiResult {
    var token:String?
    
    required init(_ json: JSON) {
        super.init(json)
        self.token = json["data"]["token"].string
    }
}

