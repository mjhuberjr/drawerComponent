//
//  DrawerPanGestureRecognizer.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/12/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class DrawerPanGestureRecognizer: UIPanGestureRecognizer {
    
    let allowTap: Bool
    
    init(target: Any?, action: Selector?, allowTap: Bool) {
        self.allowTap = allowTap
        super.init(target: target, action: action)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == UIGestureRecognizerState.began { return }
        super.touchesBegan(touches, with: event)
        if !allowTap { return }
        self.state = .began
    }
    
}
