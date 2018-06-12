//
//  DrawerEvents.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

public protocol DrawerEvents {
    
    var drawerDidBeginOpening: DrawerEventClosure? { get }
    var drawerDidOpen: DrawerEventClosure? { get }
    
    var drawerDidBeginMaxOpening: DrawerEventClosure? { get }
    var drawerDidMaxOpen: DrawerEventClosure? { get }
    
    var drawerDidBeginClosing: DrawerEventClosure? { get }
    var drawerDidClose: DrawerEventClosure? { get }
    
}

public extension DrawerEvents {
    
    var drawerDidBeginOpening: DrawerEventClosure? { return nil }
    var drawerDidOpen: DrawerEventClosure? { return nil }
    
    var drawerDidBeginMaxOpening: DrawerEventClosure? { return nil }
    var drawerDidMaxOpen: DrawerEventClosure? { return nil }
    
    var drawerDidBeginClosing: DrawerEventClosure? { return nil }
    var drawerDidClose: DrawerEventClosure? { return nil }
    
}
