//
//  Data+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

extension Data {
    var asJsonString: String? {
        if let dict = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            return dict.asJsonString
        }

        return nil
    }
}
