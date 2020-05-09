//
//  DistanceService.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct DistanceService {
    static func calculateDistanceTo(location: SILocation) -> Double {
        let earthRadius = Double(UIConstants.earthRadius.rawValue)
        let dublinOffice = SILocation.dublinOfficeLocation

        let deltaLong = (dublinOffice.longitude - location.longitude).asRadians.magnitude

        let a = sin(dublinOffice.latitude.asRadians) * sin(location.latitude.asRadians)
        let b = cos(dublinOffice.latitude.asRadians) * cos(location.latitude.asRadians) * cos(deltaLong)
        let angle = acos(a + b)

        return earthRadius * angle
    }
}
