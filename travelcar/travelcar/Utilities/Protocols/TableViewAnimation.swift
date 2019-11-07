//
//  TableViewAnimation.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

protocol UITableViewAnimation {}

extension UITableViewAnimation {
    func hide(_ tableView: UITableView) {
        UIView.animate(withDuration: 0.5) { [weak tableView] in
            tableView?.alpha = 0
        }
    }

    func show(_ tableView: UITableView) {
        UIView.animate(withDuration: 0.5) { [weak tableView] in
            tableView?.alpha = 1
        }
    }
}
