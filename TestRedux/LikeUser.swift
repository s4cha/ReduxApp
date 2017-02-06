//
//  LikeUser.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

enum LikeUserAction:Action {
    case success(user:User)
    case failed(user:User)
}

func LikeUser(_ user:User) -> ActionCreator  {
    return { dispatch in
        //Optimistic
        dispatch(LikeUserAction.success(user: user))
        api.latestUsers().onError { _ in
            dispatch(LikeUserAction.failed(user: user))
        }
    }
}

func likeUserReducer(_ state:MyState, action:LikeUserAction) -> MyState {
    var state = state
    switch action {
    case .success(let aUser):
        return likeUser(state, aUser: aUser)
    case .failed(let aUser):
        state.likingUserFailed = true
        state.users = state.users?.map({ user in
            var user = user
            if user.name == aUser.name {
                user.isLiked = false
            }
            return user
        })
    }
    return state
}

func likeUser(_ state:MyState, aUser:User) -> MyState {
    var state = state
    state.users = state.users?.map({ user in
        var user = user
        if user.name == aUser.name {
            user.isLiked = true
        }
        return user
    })
    return state
}
