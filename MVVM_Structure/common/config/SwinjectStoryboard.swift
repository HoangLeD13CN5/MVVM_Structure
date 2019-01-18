//
//  SwinjectStoryboard.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/15/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard
{
    @objc class func setup (){
        defaultContainer.register(AuthenticationRepos.self, factory: { _ in return AuthenticationReposImpl() })
        
        defaultContainer.register(CoworkingSpaceRepos.self, factory: { _ in return CoworkingSpaceReposImpl() })
        
        defaultContainer.storyboardInitCompleted(LoginVC.self) { r, c in
            c.loginViewModel = LoginViewModel(authRepos: r.resolve(AuthenticationRepos.self)!)
        }
    }
}
