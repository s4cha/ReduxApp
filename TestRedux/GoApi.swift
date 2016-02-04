//
//  GoApi.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import ws

struct GoApi:Api {
    
    let ws = WS("http://jsonplaceholder.typicode.com")
    
    func latestUsers() -> Promise<[User]> {
        return ws.resourcesCall(url: "/users")
    }
}