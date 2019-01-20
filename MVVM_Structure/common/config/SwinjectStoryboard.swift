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
        // api
        defaultContainer.register(LoginApi.self, factory: { _ in
            return LoginApiImpl()
        })
        
        defaultContainer.register(ListCoworkingSpaceApi.self, factory: { _ in
            return ListCoworkingSpaceApiImpl()
        })
        
        // dao
        defaultContainer.register(ListCoworkingSpaceCache.self, factory: { _ in
            return CoworkingSpaceDao()
        })
        
        // repos
        defaultContainer.register(AuthenticationRepos.self, factory: { r in
            return AuthenticationReposImpl(loginApi: r.resolve(LoginApi.self)! )
        })
        
        defaultContainer.register(CoworkingSpaceRepos.self, factory: { r in
            return CoworkingSpaceReposImpl(listCoworkingApi: r.resolve(ListCoworkingSpaceApi.self)!,
                                           dao: r.resolve(ListCoworkingSpaceCache.self)!)
        })
        
        // viewcontroller
        defaultContainer.storyboardInitCompleted(LoginVC.self) { r, c in
            c.loginViewModel = LoginViewModel(authRepos: r.resolve(AuthenticationRepos.self)!)
        }
    }
}
