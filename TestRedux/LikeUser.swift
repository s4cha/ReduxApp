//
//  LikeUser.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

enum LikeUserAction:Action {
    case Success(user:User)
    case Failed(user:User)
}

func LikeUser(user:User) -> ActionCreator  {
    return { dispatch in
        //Optimistic
        dispatch(LikeUserAction.Success(user: user))
        api.latestUsers().fails {
            dispatch(LikeUserAction.Failed(user: user))
        }
    }
}

func likeUserReducer(var state:MyState, action:LikeUserAction) -> MyState {
    switch action {
    case .Success(let aUser):
        return likeUser(state, aUser: aUser)
    case .Failed(let aUser):
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

func likeUser(var state:MyState, aUser:User) -> MyState {
    state.users = state.users?.map({ user in
        var user = user
        if user.name == aUser.name {
            user.isLiked = true
        }
        return user
    })
    return state
}
