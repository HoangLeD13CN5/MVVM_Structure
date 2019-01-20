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
    
    func convertApiDataToRealm(apiData: CoworkingApiEntity?) -> CoworkingRealmEntity {
        let realmEntity = CoworkingRealmEntity()
        realmEntity.id =  apiData?.id ?? 0
        realmEntity.title = apiData?.title
        realmEntity.descriptionWorking = apiData?.description
        realmEntity.address = apiData?.address
        realmEntity.contact = apiData?.contact
        realmEntity.location = apiData?.location
        realmEntity.publish_status = apiData?.publish_status ?? false
        realmEntity.thumbnail = apiData?.thumbnail
        realmEntity.idOrganization = apiData?.organization?.id ?? 0
        realmEntity.nameOrganization = apiData?.organization?.name
        realmEntity.phoneNumberOrganization = apiData?.organization?.phoneNumber
        realmEntity.addressOrganization = apiData?.organization?.address
        return realmEntity
    }
    
    func convertRealmToModel(realmData: CoworkingRealmEntity?) -> CoworkingModel?{
        let model = CoworkingModel()
        model.id =  realmData?.id
        model.title = realmData?.title
        model.description = realmData?.description
        model.address = realmData?.address
        model.contact = realmData?.contact
        model.location = realmData?.location
        model.publish_status = realmData?.publish_status
        model.thumbnail = realmData?.thumbnail
        let organiModel = OrganizationModel()
        organiModel.id =  realmData?.idOrganization
        organiModel.name = realmData?.nameOrganization
        organiModel.phoneNumber = realmData?.phoneNumberOrganization
        organiModel.address = realmData?.addressOrganization
        model.organization = organiModel
        return model
    }
    
}
