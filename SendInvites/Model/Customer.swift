//
//  Customer.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct Customer: Equatable {
    let id: Int
    let name: String
    private let latitudeString: String
    private let longitudeString: String

    private var latitude: Double {
        guard let latitude = Double(latitudeString) else {
            assertionFailure("Latitude is not formatted correctly")
            return 0.0
        }

        return latitude
    }

    private var longitude: Double {
        guard let longitude = Double(longitudeString) else {
            assertionFailure("longitude is not formatted correctly")
            return 0.0
        }

        return longitude
    }

    var location: SILocation {
        return SILocation(latitude: latitude, longitude: longitude)
    }

    var distanceFromOffice: Double {
        return DistanceService.calculateDistanceTo(location: location)
    }

    var isToBeInvited: Bool {
        return distanceFromOffice < 100
    }
}

extension Customer: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        latitudeString = try container.decode(String.self, forKey: .latitude)
        longitudeString = try container.decode(String.self, forKey: .longitude)
    }

    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name, latitude, longitude
    }
}

extension Customer: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(latitudeString, forKey: .latitude)
        try container.encode(longitudeString, forKey: .longitude)
    }
}

#if DEBUG
extension Customer {
    init(id: Int, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitudeString = String(latitude)
        self.longitudeString = String(longitude)

        if !TestingService.isUnderTest {
            assertionFailure("This constructor is only for testing purposes")
        }
    }
}
#endif
