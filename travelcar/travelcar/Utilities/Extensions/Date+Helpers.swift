//
//  Date+Helpers.swift
//  travelcar
//
//  Created by Fromage Charley on 07/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

extension Date {
    var stringValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.profile

        return dateFormatter.string(from: self)
    }
}
