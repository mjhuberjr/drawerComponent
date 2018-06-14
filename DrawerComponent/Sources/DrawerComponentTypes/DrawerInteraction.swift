//
//  DrawerInteraction.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

protocol DrawerInteraction: class {
    
    func panBegan()
    func panChanged(_ recognizer: UIPanGestureRecognizer)
    func panShouldEndEarly(_ velocity: CGFloat) -> Bool
    func panEnded(_ recognizer: UIPanGestureRecognizer, shouldClose: Bool)
    func toggleDrawer()
    
}

class DrawerInteractor {
    
    var presenter: DrawerComponentPresentation
    var drawerView: DrawerAnimatable
    
    // MARK: - Animation properties
    
    var runningAnimators: [UIViewPropertyAnimator] = []
    var animationProgress: [CGFloat] = []
    
    init(presenter: DrawerComponentPresentation, drawerView: DrawerAnimatable) {
        self.presenter = presenter
        self.drawerView = drawerView
    }
    
}

// MARK: - Drawer Interaction

extension DrawerInteractor: DrawerInteraction {
    
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
    
    func toggleDrawer() {
        animateIfNeeded(to: presenter.state.next, duration: 1)
        runningAnimators.forEach { $0.pauseAnimation() }
        animationProgress = runningAnimators.map { $0.fractionComplete }
    }
    
}

// MARK: Private methods

private extension DrawerInteractor {
    
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
        
        let configuration = self.presenter.drawerConfiguration
        
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
            switch self.presenter.state {
            case .open:
                self.updateConstraint(configuration.closedOffset)
            case .closed:
                self.updateConstraint(configuration.openOffset)
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
            case .open:
                self.updateConstraint(configuration.openOffset)
            case .closed:
                self.updateConstraint(configuration.closedOffset)
            }
            
            self.runningAnimators.removeAll()
        }
        
        setup(animator: transitionAnimator, scrubsLinearly: true)
        
        presenter.dataSource.propertyAnimators?.forEach { setup(animator: $0) }
    }
    
    func updateConstraint(_ offset: CGFloat) {
        drawerView.bottomConstraint.constant = offset
    }
    
    func setup(animator: UIViewPropertyAnimator, scrubsLinearly: Bool = false) {
        animator.scrubsLinearly = scrubsLinearly
        animator.startAnimation()
        self.runningAnimators.append(animator)
    }
    
}
