//
//  CustomerDecodeTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class CustomerDecodeTests: XCTestCase, FixtureLoading {
    func testDecoding() {
        do {
            let customers = try loadCustomerFrom(filename: .sampleCustomerFile, fileType: .txt, callingClass: self)
            XCTAssertEqual(customers.count, 32)
            XCTAssertEqual(customers[0].id, 1)
            XCTAssertEqual(customers[0].name, "Alice Cahill")
            XCTAssertEqual(customers[0].location.latitude, 51.92893)
            XCTAssertEqual(customers[0].location.longitude, -10.27699)
            XCTAssertEqual(customers[0].isToBeInvited, false)

            let rose = customers.first { $0.id == 24 }
            XCTAssertEqual(rose?.name, "Rose Enright")
            XCTAssertEqual(rose?.id, 24)
            XCTAssertEqual(rose?.location.latitude, 54.133333)
            XCTAssertEqual(rose?.location.longitude, -6.433333)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
