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
    
    var presenter: DrawerComponentPresentation
    var drawerView: UIViewController
    
    // MARK: - Animation properties
    
    var runningAnimators: [UIViewPropertyAnimator] = []
    var animationProgress: [CGFloat] = []
    
    init(presenter: DrawerComponentPresentation) {
        self.presenter = presenter
        self.drawerView = presenter.dataSource.drawerView
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
            
            animateIfNeeded(to: presenter.state, duration: 1)
            runningAnimators.forEach { $0.pauseAnimation() }
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
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
    
    func animateIfNeeded(to transition: DrawerState, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
            switch self.presenter.state {
            case .open:
                // TODO: Bring view to open position
                break
            case .closed:
                // TODO: Bring view to closed position
                break
            }
            self.drawerView.view.layoutIfNeeded()
        }
        
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.presenter.state = transition.next
            case .end:
                self.presenter.state = transition
            case .current: break
            }
            
            switch self.presenter.state {
            case .open: break
                // TODO: Reset to zero (or closed)
            case .closed: break
                // TODO: Reset to open (using offset)
            }
            
            self.runningAnimators.removeAll()
        }
        
        setup(animator: transitionAnimator)
        
        presenter.dataSource.propertyAnimators?.forEach { setup(animator: $0) }
    }
    
    func setup(animator: UIViewPropertyAnimator) {
        animator.scrubsLinearly = false
        animator.startAnimation()
        self.runningAnimators.append(animator)
    }
    
}
