//
//  UIView+Constraints.swift
//  MapComponent
//
//  Created by Michael J. Huber Jr. on 5/8/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

extension UIView {
    
    public func pinToEdges(of other: UIView, with padding: UIEdgeInsets = UIEdgeInsets.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            other.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.top),
            other.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding.bottom),
            other.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -padding.left),
            other.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding.right),
            ])
    }
    
}
