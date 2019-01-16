//
//  LoginAPI.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginAPI: APIService<LoginEntity?> {
    var username: String = ""
    var password:String = ""
    
    init(username:String,password:String) {
        self.username = username
        self.password = password
    }
    
    override func convertJson(_ val: JSON?) throws -> LoginEntity? {
        guard let value = val  else { return  nil }
        return LoginEntity(value)
    }
    
    override func path() -> String {
        return URLs.LOGIN
    }
    
    override func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func params() -> Parameters {
        return ["username" : self.username, "password" : self.password]
    }
}


