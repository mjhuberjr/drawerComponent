//
//  DrawerComponentPresenter.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

protocol DrawerComponentPresentation: class {
    
    var dataSource: DrawerDataSource { get }
    var drawerConfiguration: DrawerConfigurable { get }
    
    var state: DrawerState { get set }
    
}

class DrawerComponentPresenter: DrawerComponentPresentation {
    
    var dataSource: DrawerDataSource
    var drawerConfiguration: DrawerConfigurable
    
    var state: DrawerState
    
    init(dataSource: DrawerDataSource, drawerConfiguration: DrawerConfigurable, startingState: DrawerState) {
        self.dataSource = dataSource
        self.drawerConfiguration = drawerConfiguration
        self.state = startingState
    }
    
}
