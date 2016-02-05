//
//  MyState.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

struct MyState:State {
    var users:[User]?

    //Errors ? should be store in state or handled on the go??
    var failedLoadingUsers = false
    var likingUserFailed = false
    var navigationStack:[Any] = ["Users"]
}
