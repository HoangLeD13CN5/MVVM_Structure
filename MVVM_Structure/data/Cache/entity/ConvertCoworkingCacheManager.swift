//
//  ConvertCoworkingCacheManager.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/20/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation

class ConvertCoworkingCacheManager {
    static let shared = ConvertCoworkingCacheManager()
    
    private init(){}
    
    func convertModelToRealm(data: CoworkingModel?) -> CoworkingRealmEntity {
        let realmEntity = CoworkingRealmEntity()
        realmEntity.id =  data?.id ?? 0
        realmEntity.title = data?.title
        realmEntity.descriptionWorking = data?.description
        realmEntity.address = data?.address
        realmEntity.contact = data?.contact
        realmEntity.location = data?.location
        realmEntity.publish_status = data?.publish_status ?? false
        realmEntity.thumbnail = data?.thumbnail
        realmEntity.idOrganization = data?.organization?.id ?? 0
        realmEntity.nameOrganization = data?.organization?.name
        realmEntity.phoneNumberOrganization = data?.organization?.phoneNumber
        realmEntity.addressOrganization = data?.organization?.address
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
