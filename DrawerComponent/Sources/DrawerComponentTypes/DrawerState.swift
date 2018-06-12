//
//  DrawerState.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

enum DrawerState {
    case closed
    case open
    case maxOpen
}

extension DrawerState {
    var opening: DrawerState {
        switch self {
        case .closed: return .open
        case .open: return .maxOpen
        case .maxOpen: return .maxOpen
        }
    }
    
    var closing: DrawerState {
        switch self {
        case .closed: return .closed
        case .open: return .closed
        case .maxOpen: return .open
        }
    }
}
