//
//  DrawerConfigurable.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

class DrawerEventsImpl: DrawerEvents { init() { } }

public protocol DrawerConfigurable {
    
    var drawerEvents: DrawerEvents { get }
    var openOffset: CGFloat { get }
    var closedOffset: CGFloat { get }
    
}

extension DrawerConfigurable {
    
    var drawerEvents: DrawerEvents { return DrawerEventsImpl() }
    var openOffset: CGFloat { return 0.0 }
    var closedOffset: CGFloat { return 0.0 }
    
}
