//
//  TableViewController.swift
//  DrawerComponentDemo
//
//  Created by Michael J. Huber Jr. on 6/24/18.
//  Copyright © 2018 operation thirteenOne. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "This is row number \(indexPath.row)."
        return cell
    }
    
}
