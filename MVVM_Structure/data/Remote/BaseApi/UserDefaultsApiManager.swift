//
//  PreferenceService.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//  Cookie for api

import Foundation

class UserDefaultsApiManager {
    static let shared = UserDefaultsApiManager()
    
    private init(){}
    
    let TOKEN_AUTH = "TOKEN_AUTH"
    let REFERSH_TOKEN = "REFERSH_TOKEN"
   
    
    func saveToken(token:String){
        UserDefaults.standard.set(token, forKey: self.TOKEN_AUTH)
        UserDefaults.standard.synchronize()
    }
    
    func saveRefeshToken(refeshToken:String){
        UserDefaults.standard.set(refeshToken, forKey: self.REFERSH_TOKEN)
        UserDefaults.standard.synchronize()
    }
    
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: self.TOKEN_AUTH) ?? ""
    }
    
    func getRefeshToken() -> String {
        return UserDefaults.standard.string(forKey: self.REFERSH_TOKEN) ?? ""
    }
    
    
}
