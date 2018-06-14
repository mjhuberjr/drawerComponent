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
    var propertyAnimators: [UIViewPropertyAnimator]? { get }
    
}

class PrototypeDrawer: DrawerDataSource {
    
    var drawerView: UIViewController
    var propertyAnimators: [UIViewPropertyAnimator]? = nil
    
    init() {
        drawerView = UIViewController()
        setup(drawerView)
    }
    
    func setup(_ vc: UIViewController) {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Welcome"
        
        vc.view.addSubview(label)
        vc.view.backgroundColor = .orange
        
        label.pinToEdges(of: vc.view)
    }
    
}
