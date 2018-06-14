//
//  UIView+Constraints.swift
//  MapComponent
//
//  Created by Michael J. Huber Jr. on 5/8/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

extension UIView {
    
    public func pinToEdges(of other: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            other.topAnchor.constraint(equalTo: self.topAnchor),
            other.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            other.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            other.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
    }
    
}
