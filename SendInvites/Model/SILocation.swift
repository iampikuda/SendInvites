//
//  SILocation.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct SILocation: Equatable {
    let latitude: Double
    let longitude: Double

    static let dublinOfficeLocation = SILocation(latitude: 53.339428, longitude: -6.257664)
}
