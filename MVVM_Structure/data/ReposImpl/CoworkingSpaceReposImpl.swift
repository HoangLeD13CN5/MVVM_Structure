//
//  CoworkingSpaceReposImpl.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

class CoworkingSpaceReposImpl: CoworkingSpaceRepos{
    func list(limit: Int, offset: Int) -> Observable<[CoworkingModel]> {
        return ListCoworkingSpaceAPI(limit: limit,offset: offset)
            .request()
            .observeOn(MainScheduler.instance)
            .map { data in
                return data.map{ entity in
                    return ConvertCoworkingManager.shared.convertApiDataToModel(apiData: entity) ?? CoworkingModel()
                }
            }
    }
}
