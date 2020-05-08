//
//  SIError.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct SIError: Error, LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }

    let message: String

    enum CodingKeys: String, CodingKey {
        case message
    }
}
