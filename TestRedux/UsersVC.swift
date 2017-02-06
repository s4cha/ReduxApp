//
//  UsersVC.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

class UsersVC:UIViewController, StateObserver {
    
    var state:MyState!
    let v = UsersView()
    override func loadView() { view = v }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        v.button.addTarget(self, action: #selector(UsersVC.tap), for: .touchUpInside)
        v.tableView.dataSource = self
        v.tableView.delegate = self
    }
    
    func tap() {
        dispatch(FetchUsers())
    }
    
    func newState(_ newState: State) {
        state = newState as! MyState
        
        v.button.setTitle(buttonTextforState(state), for: UIControlState())
        v.tableView.reloadData()
        
        
        if state.likingUserFailed {
            let alert = UIAlertController(title: "Failed", message: "try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func buttonTextforState(_ state:MyState) -> String {
        if state.users == nil {
            return "Loading Users..."
        } else if state.failedLoadingUsers {
            return "Failed loading users"
        } else if state.users!.count == 0 {
           return "No users :("
        } else {
            var t = ""
            for u in state.users! {
                t += "\(u.name) "
            }
            return t
        }
    }
}

extension UsersVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = state.users else { return 0 }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let u = state.users![indexPath.row]
        c.textLabel?.text = u.name
        c.textLabel?.backgroundColor = .clear
        c.contentView.backgroundColor = u.isLiked  ? .yellow : .white
        return c
    }
}

extension UsersVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let u = state.users![indexPath.row]
        if !u.isLiked {
            dispatch(LikeUser(u))
        } else {
            dispatch(TappedUser(user: u))
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct TappedUser:Action {
    let user:User
}
