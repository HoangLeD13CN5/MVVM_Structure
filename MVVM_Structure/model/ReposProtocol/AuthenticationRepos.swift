//
//  AuthenticationRepos.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/16/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthenticationRepos {
    func login(username:String,password:String) -> Observable<String?>
}
