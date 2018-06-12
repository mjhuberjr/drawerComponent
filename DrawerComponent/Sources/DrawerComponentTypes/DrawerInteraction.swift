//
//  DrawerInteraction.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

protocol DrawerInteraction: class {
    
    func openDrawer()
    func closeDrawer()
    func panDrawer(recognizer: UIPanGestureRecognizer)
    
}

class DrawerInteractor {
    
    var presenter: DrawerComponentPresenter
    
    init(presenter: DrawerComponentPresenter) {
        self.presenter = presenter
    }
    
}

extension DrawerInteractor: DrawerInteraction {
    
    func openDrawer() {
        
    }
    
    func closeDrawer() {
        
    }
    
    func panDrawer(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            break
        case .changed:
            break
        case .ended:
            break
        default: break
        }
    }
    
}
