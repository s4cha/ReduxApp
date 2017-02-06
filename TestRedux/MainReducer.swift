//
//  MainReducer.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

struct MainReducer:Reducer {
    func handleAction(_ state:State, action:Action) -> State {
        let state:MyState = state as! MyState
        switch action {
        case let a as FetchUsersAction:
            return fetchUsersReducer(state, action: a)
        case let a as LikeUserAction:
            return likeUserReducer(state, action: a)
        case let a as TappedUser:
            var s = state
            s.navigationStack.append(a.user)
            return s
        case _ as NavigationBackAction:
            var s = state
            s.navigationStack.popLast()
            return s
        default:
            return state
        }
    }
}
