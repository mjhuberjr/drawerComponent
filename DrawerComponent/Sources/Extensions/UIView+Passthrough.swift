//
//  UIView+Passthrough.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/15/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

class PassthroughView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }
    
}
