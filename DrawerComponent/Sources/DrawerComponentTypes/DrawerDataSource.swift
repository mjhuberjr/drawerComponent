//
//  DrawerDataSource.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

public protocol DrawerDataSource {
    
    var drawerView: UIViewController { get }
    
}

class PrototypeDrawer: DrawerDataSource {
    
    var drawerView: UIViewController
    
    init() {
        drawerView = UIViewController()
        setup(drawerView)
    }
    
    func setup(_ vc: UIViewController) {
        let label = UILabel()
        label.textAlignment = .center
        vc.view.addSubview(label)
        
    }
    
}
