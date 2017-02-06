//
//  Api.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import then

var api:Api!

protocol Api {
    func latestUsers() -> Promise<[User]>
}
