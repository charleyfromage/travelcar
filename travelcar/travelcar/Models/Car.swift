//
//  Car.swift
//  travelcar
//
//  Created by Fromage Charley on 06/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import UIKit

struct Car {
    let make: String
    let model: String
    let year: Int
    let pictureURL: String
    let equipments: [String]?
}

extension Car: Decodable {
    private enum CodingKeys: String, CodingKey {
        case make = "make"
        case model = "model"
        case year = "year"
        case pictureURL = "picture"
        case equipments = "equipments"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.make = try container.decode(String.self, forKey: .make)
        self.model = try container.decode(String.self, forKey: .model)
        self.year = try container.decode(Int.self, forKey: .year)
        self.pictureURL = try container.decode(String.self, forKey: .pictureURL)
        self.equipments = try container.decode([String]?.self, forKey: .equipments)
    }
}

enum CarFeature: Int, CaseIterable {
    case make
    case model
    case year

    var text: String {
        switch self {
            case .make: return Strings.Details.make
            case .model: return Strings.Details.model
            case .year: return Strings.Details.year
        }
    }
}

enum Equipment: String {
    case AC = "Climatisation"
    case assistance = "Assistance 24h/24"
    case childrenSeats = "Siege enfant"
    case airbags = "Airbags"
    case ABS = "ABS"
    case GPS = "GPS"

    var image: UIImage {
        switch self {
            case .AC: return Assets.Details.AC
            case .assistance: return Assets.Details.assistance
            case .childrenSeats: return Assets.Details.childrenSeats
            case .airbags: return Assets.Details.airbags
            case .ABS: return Assets.Details.ABS
            case .GPS: return Assets.Details.GPS
        }
    }
}
