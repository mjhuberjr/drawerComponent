//
//  DrawerRootViewController.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit

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
        
        setupStartingPosition()
        setupInteractor()
    }
    
}

// MARK: - Private methods

private extension DrawerRootViewController {
    
    func setupStartingPosition() {
        let drawerConfiguration = presenter.drawerConfiguration
        switch presenter.state {
        case .open:
            bottomConstraint = drawerConfiguration.closedOffset
        case .closed:
            bottomConstraint = drawerConfiguration.openOffset
        }
    }
    
    func setupInteractor() {
        let interactor = DrawerInteractor(presenter: presenter)
        self.interactor = interactor
    }
    
    func setupGestures() {
        
    }
    
}
