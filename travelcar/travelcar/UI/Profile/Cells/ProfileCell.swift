//
//  ProfileCell.swift
//  travelcar
//
//  Created by Fromage Charley on 07/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet public weak var textField: UITextField!

    var section: ProfileSection?

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
    }

    func setup(with section: ProfileSection, and profile: Profile) {
        self.section = section

        label.text = String(format: "%@ : ", section.text)

        switch section {
            case .firstName: textField.text = profile.firstName != nil ? profile.firstName : section.placeholder
            case .lastName: textField.text = profile.lastName != nil ? profile.lastName : section.placeholder
            case .address: textField.text = profile.address != nil ? profile.address : section.placeholder
            case .birthDate: textField.text = profile.birthDate != nil ? (profile.birthDate?.stringValue ?? section.placeholder) : section.placeholder
        }
    }
}
