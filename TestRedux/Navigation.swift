//
//  Navigation.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 05/02/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit

class Navigation:NSObject,StateObserver, UINavigationControllerDelegate {
    
    var controller:UIViewController { return navVC }
    
    var previousNavigationStack = [Any]()
    
    override init() {
        super.init()
        navVC.delegate = self
        subscribe(self)
    }
    
    fileprivate let navVC = UINavigationController()
    
    func newState(_ newState: State) {
        let state = newState as! MyState
        if previousNavigationStack.count != state.navigationStack.count {
            if previousNavigationStack.isEmpty {
                navVC.viewControllers = controllersForNavigationStack(state.navigationStack)
            } else {
                
                print(state.navigationStack)
                
                //Push
                if previousNavigationStack.count <= state.navigationStack.count {
                    if let vc = controllerForControllerId(state.navigationStack.last!) {
                        navVC.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        previousNavigationStack = state.navigationStack
    }
    
    func controllersForNavigationStack(_ navigationStack:[Any]) -> [UIViewController] {
        var a = [UIViewController]()
        for vcName in navigationStack {
            if let vc = controllerForControllerId(vcName) {
                a.append(vc)
            }
        }
        return a
    }
    
    func controllerForControllerId(_ vcId:Any) -> UIViewController? {
        switch vcId {
        case let s as String where s == "Users" :
            return UsersVC()
        case let s as User:
            return UserVC(user: s)
        default:
            return nil
            
        }
    }
    
    var previousViewControllers = [UIViewController]()
    
    // Make sure Back action syncs the navigation State.
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            dispatch(NavigationBackAction())
        default: ()
        }
        return nil
    }
}

struct NavigationBackAction:Action {
}



// Good stuf to natch name -> Bare VC
//if let vcClass = NSClassFromString("TestRedux."+vcName) as? UIViewController.Type{
//
//    a.append(vcClass.init())
