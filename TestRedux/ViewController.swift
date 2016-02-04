//
//  ViewController.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//


import UIKit


class ViewController: UIViewController, StateObserver {
    
    var state:MyState!
    let v = View()
    override func loadView() { view = v }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        v.button.addTarget(self, action: "tap", forControlEvents: .TouchUpInside)
        v.tableView.dataSource = self
        v.tableView.delegate = self
    }
    
    func tap() {
        dispatch(LoadUsersActionCreator())
    }
    
    func newState(newState: State) {
        state = newState as! MyState
        
        v.button.setTitle(buttonTextforState(state), forState: .Normal)
        v.tableView.reloadData()
        
        
        if state.likingUserFailed {
            let alert = UIAlertController(title: "Failed", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func buttonTextforState(state:MyState) -> String {
        
        if state.isLoadingUsers {
            return "Loading Users..."
        } else if state.failedLoadingUsers {
            return "Failed loading users"
        } else if state.users.count == 0 {
           return "No users :("
        } else {
            var t = ""
            for u in state.users {
                t += "\(u.name) "
            }
            return t
        }
    }
}

extension ViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let u = state.users[indexPath.row]
        c.textLabel?.text = u.name
        c.textLabel?.backgroundColor = .clearColor()
        c.contentView.backgroundColor = u.isLiked  ? .yellowColor() : .whiteColor()
        return c
    }
}

extension ViewController:UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let u = state.users[indexPath.row]
        if !u.isLiked {
            dispatch(LikeUserActionCreator(u))
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
