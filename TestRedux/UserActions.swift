//
//  UserActions.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 03/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//


func LoadUsersActionCreator() -> ActionCreator  {
    return { dispatch in
        dispatch(LoadingUsersAction.Loading)
        api.latestUsers().then { users in
            dispatch(LoadingUsersAction.Success(users: users))
        }.fails {
            dispatch(LoadingUsersAction.Failed)
        }
    }
}


func LikeUserActionCreator(user:User) -> ActionCreator  {
    return { dispatch in
        //Optimistic
        dispatch(LikeUserActionSuccess(user: user))
        api.latestUsers().fails {
            dispatch(LikeUserActionFailed(user: user))
        }
    }
}


// Like User

struct LikeUserActionLoading:Action {
    let user:User
}

struct LikeUserActionFailed:Action {
    let user:User
}

struct LikeUserActionSuccess:Action {
    let user:User
}

enum LoadingUsersAction:Action {
    case Loading
    case Success(users:[User])
    case Failed
}
