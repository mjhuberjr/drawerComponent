//
//  AppDelegate.swift
//  DrawerComponentDemo
//
//  Created by Michael J. Huber Jr. on 6/12/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit
import DrawerComponent

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        class DrawerComponentDataSource: DrawerDataSource {
            var drawerViews: [UIViewController]
            var propertyAnimators: [UIViewPropertyAnimator]? = nil
            init() {
                let vc = TableViewController()
                drawerViews = [vc]
            }
        }
        
        let dataSource = DrawerComponentDataSource()
        let rootCoordinator = DrawerComponentCoordinator(dataSource: dataSource)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator.drawerComponentViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

