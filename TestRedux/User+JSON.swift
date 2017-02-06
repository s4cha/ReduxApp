//
//  User+JSON.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 06/02/2017.
//  Copyright © 2017 s4cha. All rights reserved.
//

import Arrow

extension User:ArrowParsable {
    
    public mutating func deserialize(_ json: JSON) {
        identifier <-- json["id"]
        name <-- json["name"]
    }
}
