//
//  DrawerRootViewController.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit

public protocol DrawerAnimatable: class {
    
    var bottomConstraint: NSLayoutConstraint! { get set }
    var view: UIView! { get set }
    
}

public extension DrawerAnimatable where Self: UIViewController { }

class DrawerRootViewController: UIViewController {
    
    @IBOutlet var drawerView: UIView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    private var presenter: DrawerComponentPresentation
    var interactor: DrawerInteraction!
    
    init(presenter: DrawerComponentPresentation) {
        self.presenter = presenter
        
        let bundle = Bundle(for: DrawerRootViewController.self)
        super.init(nibName: nil, bundle: bundle)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDrawerView()
        setupStartingPosition()
        setupInteractor()
        setupGestures()
    }
    
}

// MARK: - Private methods

private extension DrawerRootViewController {
    
    func setupDrawerView() {
        let drawer = presenter.dataSource.drawerView
        embed(drawer, into: drawerView)
    }
    
    func setupStartingPosition() {
        let drawerConfiguration = presenter.drawerConfiguration
        switch presenter.state {
        case .open:
            bottomConstraint.constant = drawerConfiguration.openOffset
        case .closed:
            bottomConstraint.constant = drawerConfiguration.closedOffset
        }
    }
    
    func setupInteractor() {
        let interactor = DrawerInteractor(presenter: presenter, drawerView: self)
        self.interactor = interactor
    }
    
    func setupGestures() {
        let panGesture = DrawerPanGestureRecognizer(target: self, action: #selector(drawerPanned(recognizer:)))
        drawerView.addGestureRecognizer(panGesture)
    }
    
    @objc func drawerPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactor.panBegan()
        case .changed:
            interactor.panChanged(recognizer)
        case .ended:
            
            let yVelocity = recognizer.velocity(in: drawerView).y
            let shouldClose = yVelocity > 0
            if interactor.panShouldEndEarly(yVelocity) { break }
            interactor.panEnded(recognizer, shouldClose: shouldClose)
            
        default: break
        }
    }
    
}

// MARK: DrawerAnimatable

extension DrawerRootViewController: DrawerAnimatable { }
