//
//  WeblinkTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class WeblinkTests: XCTestCase {

    func test_forceUnwrapping() {
        for weblink in Weblink.allCases {
            XCTAssertNotNil(URL(string: weblink.stringValue))
        }
    }
}
