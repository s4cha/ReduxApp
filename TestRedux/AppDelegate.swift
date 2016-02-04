//
//  AppDelegate.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

import ws
protocol Api {
    func latestUsers() -> Promise<[User]>
}

var api:Api!


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        api = GoApi()
        store = DefaultStore(aState: MyState(), aReducer: MyReducer())
        return true
    }
}


// this is My Domain

struct MyState:State {
    var isOn = false
    var failedLoadingUsers = false
    var users = [User]()
    var isLoadingUsers = false
    
    var likingUserFailed = false
}

struct User {
    var name = "Tom"
    var isLiked:Bool = false
}

import Arrow
extension User:ArrowParsable {
    init(json: JSON) {
        name <-- json["name"]
    }
}


import Foundation


func loadingUsersReducer(var state:MyState, action:LoadingUsersAction) -> MyState {
    switch action {
    case .Loading:
        state.isLoadingUsers = true
        state.failedLoadingUsers = false
        state.isOn = !state.isOn
    case .Success(let users):
        state.users = users
        state.failedLoadingUsers = false
        state.isLoadingUsers = false
    case LoadingUsersAction.Failed:
        state.failedLoadingUsers = true
        state.isLoadingUsers = false
    }
    return state
}

struct MyReducer:Reducer {
    func handleAction(state:State, action:Action) -> State {
        
        print(action)
        var state:MyState = state as! MyState
        
        switch action {
            
        case let a as LoadingUsersAction:
            state = loadingUsersReducer(state, action: a)
            
        //Optimistic
        case let a as LikeUserActionSuccess: ()
        state.users = state.users.map({ user in
            var user = user
            if user.name == a.user.name {
                user.isLiked = true
            }
            return user
        })
            
        case let a as LikeUserActionFailed:
            state.likingUserFailed = true
            //go back to previous state.
            state.users = state.users.map({ user in
                var user = user
                if user.name == a.user.name {
                    user.isLiked = false
                }
                return user
            })
            
            //do nothing
        default:()
        }
        
        return state
    }
}
