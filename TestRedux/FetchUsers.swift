//
//  FetchUsers.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

enum FetchUsersAction:Action {
    case Loading
    case Success(users:[User])
    case Failed
}

func FetchUsers() -> ActionCreator  {
    return { dispatch in
        dispatch(FetchUsersAction.Loading)
        api.latestUsers().then { users in
            dispatch(FetchUsersAction.Success(users: users))
        }.fails {
            dispatch(FetchUsersAction.Failed)
        }
    }
}

func fetchUsersReducer(var state:MyState, action:FetchUsersAction) -> MyState {
    switch action {
    case .Loading:
        state.users = nil
        state.failedLoadingUsers = false
    case .Success(let users):
        state.users = users
        state.failedLoadingUsers = false
    case .Failed:
        state.failedLoadingUsers = true
    }
    return state
}
