//
//  CarFeatureCell.swift
//  travelcar
//
//  Created by Fromage Charley on 07/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

class CarFeatureCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    func setup(with title: String, and value: String) {
        textLabel?.text = String(format: "%@ : %@", title.capitalized, value.capitalized)
    }
}
