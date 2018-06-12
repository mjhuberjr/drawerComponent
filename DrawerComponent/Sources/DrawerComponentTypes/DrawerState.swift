//
//  DrawerState.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

public enum DrawerState {
    case closed
    case open
}

extension DrawerState {
    
    var next: DrawerState {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
    
}
