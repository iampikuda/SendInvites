//
//  SIErrorTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class SIErrorTests: XCTestCase {
    func test_localizedDescription() {
        let error = SIError(message: "Testing testing 1,2,3")

        XCTAssertEqual(error.localizedDescription, "Testing testing 1,2,3")
    }
}
