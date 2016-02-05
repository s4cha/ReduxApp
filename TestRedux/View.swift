//
//  View.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 03/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

class UsersView:UIView {
    
    let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
    let button = UIButton()
    convenience init() {
        self.init(frame:CGRectZero)
        
        addSubview(tableView)
        
        backgroundColor = .whiteColor()
        button.backgroundColor = .grayColor()
        addSubview(button)
        button.frame = CGRectMake(100, UIScreen.mainScreen().bounds.height-150, 300, 100)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
