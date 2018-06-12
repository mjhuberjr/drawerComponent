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
    
    init() {
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
    }
    
}

// MARK: - Private methods

private extension DrawerRootViewController {
    
    
    
}
