//
//  DrawerInteraction.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

@objc protocol DrawerInteraction: class {
    
    func toggleDrawer()
    @objc func drawerPanned(recognizer: UIPanGestureRecognizer)
    
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
    
    func toggleDrawer() {
        animateIfNeeded(to: presenter.state, duration: 1)
        runningAnimators.forEach { $0.pauseAnimation() }
        animationProgress = runningAnimators.map { $0.fractionComplete }
    }
    
    @objc func drawerPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            panBegan()
        case .changed:
            panChanged(recognizer)
        case .ended:
            
            let yVelocity = recognizer.velocity(in: drawerView.view).y
            let shouldClose = yVelocity > 0
            if panShouldEndEarly(yVelocity) { break }
            panEnded(recognizer, shouldClose: shouldClose)
            
        default: break
        }
    }
    
}

// MARK: Private methods

private extension DrawerInteractor {
    
    func panBegan() {
        toggleDrawer()
    }
    
    func panChanged(_ recognizer: UIPanGestureRecognizer) {
        let openOffset = presenter.drawerConfiguration.openOffset
        
        let translation = recognizer.translation(in: drawerView.view)
        var fraction = -translation.y / openOffset
        
        if presenter.state == .open { fraction *= -1 }
        if runningAnimators[0].isReversed { fraction *= -1 }
        
        for (index, animator) in runningAnimators.enumerated() {
            animator.fractionComplete = fraction + animationProgress[index]
        }
    }
    
    func panShouldEndEarly(_ velocity: CGFloat) -> Bool {
        if velocity == 0 {
            continueAnimations()
            return true
        }
        return false
    }
    
    func panEnded(_ recognizer: UIPanGestureRecognizer, shouldClose: Bool) {
        switch presenter.state {
        case .open:
            reverseOpen(shouldClose: shouldClose)
        case .closed:
            reverseClose(shouldClose: shouldClose)
        }
        
        continueAnimations()
    }
    
    func continueAnimations() {
        runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
    }
    
    func reverseOpen(shouldClose: Bool) {
        if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
        if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
    }
    
    func reverseClose(shouldClose: Bool) {
        if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
        if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
    }
    
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
