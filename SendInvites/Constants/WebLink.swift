//
//  WebLink.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

enum Weblink: CaseIterable {
    case customerList1

    var stringValue: String {
        switch self {
        case .customerList1:
            return "https://s3.amazonaws.com/intercom-take-home-test/customers.txt"
        }
    }

    var url: URL {
        return URL(string: self.stringValue)!
    }
}
