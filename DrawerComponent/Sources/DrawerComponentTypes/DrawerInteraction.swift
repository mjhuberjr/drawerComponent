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
    var runningAnimators: [UIViewPropertyAnimator] = []
    
    init(presenter: DrawerComponentPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - Drawer Interaction

extension DrawerInteractor: DrawerInteraction {
    
    func openDrawer() {
        
    }
    
    func closeDrawer() {
        
    }
    
    @objc func panDrawer(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateIfNeeded(to: presenter.transition, duration: 1)
            
        case .changed:
            break
        case .ended:
            break
        default: break
        }
    }
    
}

// MARK: Private methods

private extension DrawerInteractor {
    
    func animateIfNeeded(to transition: DrawerTransition, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }
    }
    
}
