//
//  ConvertCoworking.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import SwiftyJSON

class ConvertCoworkingManager {
    
    static let shared = ConvertCoworkingManager()
    
    private init(){}
    
    func convertApiDataToModel(apiData: OrganizationAPIEntity?) -> OrganizationModel?{
        let model = OrganizationModel()
        model.id =  apiData?.id
        model.name = apiData?.name
        model.phoneNumber = apiData?.phoneNumber
        model.address = apiData?.address
        return model
    }
    
    func convertApiDataToModel(apiData: CoworkingApiEntity?) -> CoworkingModel?{
        let model = CoworkingModel()
        model.id =  apiData?.id
        model.title = apiData?.title
        model.description = apiData?.description
        model.address = apiData?.address
        model.contact = apiData?.contact
        model.location = apiData?.location
        model.publish_status = apiData?.publish_status
        model.thumbnail = apiData?.thumbnail
        model.organization = self.convertApiDataToModel(apiData: apiData?.organization)
        return model
    }
}
