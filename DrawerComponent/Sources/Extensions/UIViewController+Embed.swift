//
//  UIViewController+Embed.swift
//  MapComponent
//
//  Created by Michael J. Huber Jr. on 5/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func embed(_ vc: UIViewController, into view: UIView, with padding: UIEdgeInsets = UIEdgeInsets.zero) {
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vc.view)
        
        pinConstraints(vc.view, into: view, with: padding)
    }
    
    private func pinConstraints(_ view: UIView, into other: UIView? = nil, with padding: UIEdgeInsets) {
        let otherView = other ?? self.view!
        view.pinToEdges(of: otherView, with: padding)
    }
    
}
