//
//  Encodable+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary =
            try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                throw NSError()
        }
        return dictionary
    }
}
