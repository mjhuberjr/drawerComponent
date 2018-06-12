//
//  DrawerInteraction.swift
//  DrawerComponent
//
//  Created by Michael J. Huber Jr. on 6/11/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import Foundation

protocol DrawerInteraction: class {
    
    func openDrawer()
    func closeDrawer()
    
}

class DrawerInteractor {
    
    var presenter: DrawerComponentPresenter
    
    init(presenter: DrawerComponentPresenter) {
        self.presenter = presenter
    }
    
}
