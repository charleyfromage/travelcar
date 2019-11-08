//
//  Assets.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

enum Assets {
    enum List {
        static let searchOn = #imageLiteral(resourceName: "car")
        static let searchOff = #imageLiteral(resourceName: "car").alpha(0.5)
    }

    enum Details {
        static let AC = #imageLiteral(resourceName: "AC")
        static let assistance = #imageLiteral(resourceName: "24")
        static let childrenSeats = #imageLiteral(resourceName: "childrenProof")
        static let airbags = #imageLiteral(resourceName: "airbags")
        static let ABS = #imageLiteral(resourceName: "ABS")
        static let GPS = #imageLiteral(resourceName: "gps")
    }

    enum Profile {
        static let profileOn = #imageLiteral(resourceName: "profile")
        static let profileOff = #imageLiteral(resourceName: "profile").alpha(0.5)

        static let editProfilePicture = #imageLiteral(resourceName: "editPicture")
    }
}
