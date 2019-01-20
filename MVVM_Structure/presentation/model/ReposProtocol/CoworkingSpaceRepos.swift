//
//  CoworkingSpaceRepos.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/18/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

protocol CoworkingSpaceRepos {
    func list(limit:Int,offset:Int) -> Observable<[CoworkingModel]>
}
