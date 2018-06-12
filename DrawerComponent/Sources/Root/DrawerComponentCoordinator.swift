//
//  DrawerComponentCoordinator.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

public protocol DrawerComponentCoordination: class {
    
    func drawerComponentViewController() -> UIViewController
    
    // MARK: - Interactions
    func openDrawer()
    func closeDrawer()
    
}

// MARK: - Default implementations if not passed in from consumer of DrawerComponent

class DrawerConfigurableImpl: DrawerConfigurable { init () { } }

public class DrawerComponentCoordinator: DrawerComponentCoordination {
    
    fileprivate let rootViewController: DrawerRootViewController
    fileprivate var interactor: DrawerInteraction? {
        if rootViewController.isViewLoaded {
            return rootViewController.interactor
        }
        return nil
    }
    
    public init(dataSource: DrawerDataSource?, drawerConfigurable: DrawerConfigurable? = nil, startingState: DrawerState = .closed) {
        let dataSource = dataSource ?? PrototypeDrawer()
        let drawerConfiguration = drawerConfigurable ?? DrawerConfigurableImpl()
        let presenter = DrawerComponentPresenter(dataSource: dataSource, drawerConfiguration: drawerConfiguration, startingState: startingState)
        rootViewController = DrawerRootViewController(presenter: presenter)
    }
    
    public func drawerComponentViewController() -> UIViewController {
        return rootViewController
    }
    
}

// MARK: - Interactions

extension DrawerComponentCoordinator {
    
    public func openDrawer() {
        
    }
    
    public func closeDrawer() {
        
    }
    
}
