//
//  ApiProtocol.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/20/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginApi {
    func requestApi() -> Observable<String>
    func setParamater(username:String,password:String)
}

protocol ListCoworkingSpaceApi {
    func requestApi() -> Observable<[CoworkingModel]>
    func setParamater(limit: Int, offset: Int)
}
