//
//  FetchUsers.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

enum FetchUsersAction:Action {
    case loading
    case success(users:[User])
    case failed
}

func FetchUsers() -> ActionCreator  {
    return { dispatch in
        dispatch(FetchUsersAction.loading)
        api.latestUsers().then { users in
            dispatch(FetchUsersAction.success(users: users))
        }.onError { _ in
            dispatch(FetchUsersAction.failed)
        }
    }
}

func fetchUsersReducer(_ state:MyState, action:FetchUsersAction) -> MyState {
    var state = state
    switch action {
    case .loading:
        state.users = nil
        state.failedLoadingUsers = false
    case .success(let users):
        state.users = users
        state.failedLoadingUsers = false
    case .failed:
        state.failedLoadingUsers = true
    }
    return state
}
