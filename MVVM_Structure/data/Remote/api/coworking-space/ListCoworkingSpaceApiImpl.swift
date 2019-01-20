//
//  ListCoworkingSpaceAPI.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class ListCoworkingSpaceApiImpl: APIService<[CoworkingApiEntity?]>, ListCoworkingSpaceApi {
   
    var limit:Int = 0
    var offset:Int = 0
    
    func requestApi() -> Observable<[CoworkingModel]> {
        return request().map { data in
            return data.map{ entity in
                return ConvertCoworkingApiManager.shared.convertApiDataToModel(apiData: entity) ?? CoworkingModel()
            }
        }
    }
    
    func setParamater(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
   
    
    override func convertJson(_ val: JSON?) throws -> [CoworkingApiEntity?] {
        guard let value = val  else { return  [] }
        var listCoworking:[CoworkingApiEntity?] = []
        let jsonArr:[JSON] = value["data"]["results"].arrayValue
        for coworking in jsonArr {
            listCoworking.append(CoworkingApiEntity(coworking))
        }
        return listCoworking
    }
    
    override func path() -> String {
        return URLs.LIST_COWORKING
    }
    
    override func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    override func params() -> Parameters {
        return ["limit" : String(self.limit), "offset" : String(self.offset)]
    }
}




