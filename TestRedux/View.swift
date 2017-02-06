//
//  View.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 03/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

class UsersView:UIView {
    
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    let button = UIButton()
    convenience init() {
        self.init(frame:CGRect.zero)
        
        addSubview(tableView)
        
        backgroundColor = .white
        button.backgroundColor = .gray
        addSubview(button)
        button.frame = CGRect(x: 100, y: UIScreen.main.bounds.height-150, width: 300, height: 100)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
