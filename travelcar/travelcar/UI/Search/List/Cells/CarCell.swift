//
//  CarCell.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    func setup(with car: Car, and searchText: String? = nil) {
        textLabel?.attributedText = car.make.capitalized.attributedStringByHighlighting(searchText, with: .yellow)
    }
}
