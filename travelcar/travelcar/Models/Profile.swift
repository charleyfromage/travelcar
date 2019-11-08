//
//  Profile.swift
//  travelcar
//
//  Created by Fromage Charley on 07/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import Foundation
import UIKit

struct Profile {
    var photo: UIImage?
    var firstName: String?
    var lastName: String?
    var address: String?
    var birthDate: Date?

    init() {}
}

extension Profile: Equatable {
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        return (lhs.firstName == rhs.firstName)
            && (lhs.lastName == rhs.lastName)
            && (lhs.address == rhs.address)
            && (lhs.birthDate == rhs.birthDate)
            && (lhs.photo?.pngData() == rhs.photo?.pngData())
    }
}

extension Profile: Codable {

    private enum CodingKeys: String, CodingKey {
        case photo
        case firstName
        case lastName
        case address
        case birthDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.firstName = try container.decode(String?.self, forKey: .firstName)
        self.lastName = try container.decode(String?.self, forKey: .lastName)
        self.address = try container.decode(String?.self, forKey: .address)
        self.birthDate = try container.decode(Date?.self, forKey: .birthDate)

        let photoData = try? container.decode(Data?.self, forKey: CodingKeys.photo)
        if let photoData = photoData, let photo = UIImage(data: photoData) {
            self.photo = photo
        } else {
            photo = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(firstName, forKey: CodingKeys.firstName)
        try container.encode(lastName, forKey: CodingKeys.lastName)
        try container.encode(address, forKey: CodingKeys.address)
        try container.encode(birthDate, forKey: CodingKeys.birthDate)
        try container.encode(photo?.pngData(), forKey: CodingKeys.photo)
    }
}
