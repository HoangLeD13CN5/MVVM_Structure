//
//  CacheProtocol.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/20/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

protocol ListCoworkingSpaceCache {
    func createOrUpdate(listCoworking:[CoworkingModel]) throws
    func getListCoworking() throws -> [CoworkingModel]
}
