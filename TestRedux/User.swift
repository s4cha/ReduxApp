//
//  User.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 04/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

struct User {
    var identifier:Int = 0
    var name = "Tom"
    var isLiked:Bool = false
}


// TODO should be in goapi but it crashed compiler :(
import Arrow
extension User:ArrowParsable {
    init(json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
    }
}