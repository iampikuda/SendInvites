//
//  Customer.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct Customer: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double

    var location: SILocation {
        return SILocation(latitude: latitude, longitude: longitude)
    }

    var distanceFromOffice: Double {
        return DistanceService.calculateDistanceTo(location: location)
    }

    var isToBeInvited: Bool {
        return distanceFromOffice < 100
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        if let latitude = Double(latitudeString) {
            self.latitude = latitude
        } else {
            throw SIError(message: "latitude not properly formatted")
        }

        let longitudeString = try container.decode(String.self, forKey: .longitude)
        if let longitude = Double(longitudeString) {
            self.longitude = longitude
        } else {
            throw SIError(message: "longitude not properly formatted")
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name, latitude, longitude
    }
}

//{"latitude": "52.986375", "user_id": 12, "name": "Christina McArdle", "longitude": "-6.043701"}
