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

    func setDrawerEnabled(_ isEnabled: Bool)
}

public extension DrawerAnimatable where Self: UIViewController { }

public class DrawerRootViewController: UIViewController {
    
    @IBOutlet var drawerView: UIView!
    @IBOutlet public var bottomConstraint: NSLayoutConstraint!
    
    private var panGesture: DrawerPanGestureRecognizer?
    
    private var presenter: DrawerComponentPresentation
    var interactor: DrawerInteraction!
    
    var topCornerRadius: CGFloat
    
    private var isDrawerEnabled: Bool {
        didSet {
            if oldValue == isDrawerEnabled { return }
            if isDrawerEnabled { setupGestures() } else { removeGestures() }
        }
    }
    
    init(presenter: DrawerComponentPresentation, isDrawerEnabled: Bool, topCornerRadius: CGFloat) {
        self.presenter = presenter
        self.isDrawerEnabled = isDrawerEnabled
        self.topCornerRadius = topCornerRadius
        
        let bundle = Bundle(for: DrawerRootViewController.self)
        super.init(nibName: nil, bundle: bundle)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupDrawerView()
        setupStartingPosition()
        setupInteractor()
        if isDrawerEnabled { setupGestures() }
    }
    
    public func setDrawerEnabled(_ isEnabled: Bool) {
        isDrawerEnabled = isEnabled
    }
    
}

// MARK: - Private methods

private extension DrawerRootViewController {
    
    func setupDrawerView() {
        drawerView.backgroundColor = .clear
        roundTopCorners(view: drawerView)
        
        view.backgroundColor = .clear
        
        let views = presenter.dataSource.drawerViews
        for vc in views {
            roundTopCorners(view: vc.view)
            embed(vc, into: drawerView)
        }
    }
    
    func roundTopCorners(view: UIView) {
        let maskPath1 = UIBezierPath(roundedRect: view.bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii: CGSize(width: topCornerRadius, height: topCornerRadius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = view.bounds
        maskLayer1.path = maskPath1.cgPath
        view.layer.mask = maskLayer1
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
        let allowTap = presenter.drawerConfiguration.allowTapGesture
        panGesture = DrawerPanGestureRecognizer(target: self, action: #selector(drawerPanned(recognizer:)), allowTap: allowTap)
        panGesture?.delegate = self
        drawerView.addGestureRecognizer(panGesture!)
    }
    
    func removeGestures() {
        if let panGesture = panGesture {
            drawerView.removeGestureRecognizer(panGesture)
        }
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

extension DrawerRootViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
