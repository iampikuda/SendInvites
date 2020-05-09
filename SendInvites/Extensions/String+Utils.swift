//
//  String+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return emailPred.evaluate(with: self)
    }

    func toData() -> Data? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return data
    }
}
