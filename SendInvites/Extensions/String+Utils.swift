//
//  String+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

extension String {
    func toData() -> Data? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return data
    }
}
