//
//  AppDelegate.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        api = GoApi()
        store = DefaultStore(aState: MyState(), aReducer: MainReducer())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Navigation().controller
        window?.makeKeyAndVisible()
        return true
    }
}
