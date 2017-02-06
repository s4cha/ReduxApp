//
//  UserVC.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 05/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

class UserVC:UIViewController {
 
    required init(user:User) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
