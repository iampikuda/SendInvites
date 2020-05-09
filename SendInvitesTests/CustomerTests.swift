//
//  CustomerTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class CustomerTests: XCTestCase {

    func test_location() {
        let latitude = 52.986375
        let longitude = -6.043701

        let christina = Customer(id: 12, name: "Christina McArdle", latitude: latitude, longitude: longitude)

        XCTAssertEqual(christina.location, SILocation(latitude: latitude, longitude: longitude))
    }

    func test_distanceFromOffice() {
        let latitude = 52.986375
        let longitude = -6.043701

        let christina = Customer(id: 12, name: "Christina McArdle", latitude: latitude, longitude: longitude)

        XCTAssertEqual(christina.distanceFromOffice.rounded(.up), 42)
    }

    func test_isToBeInvited() {
        let latitude = 52.986375
        let longitude = -6.043701

        let christina = Customer(id: 12, name: "Christina McArdle", latitude: latitude, longitude: longitude)

        XCTAssertTrue(christina.isToBeInvited)
    }

    func test_equatable() {
        let latitude = 52.986375
        let longitude = -6.043701

        let christina = Customer(id: 12, name: "Christina McArdle", latitude: latitude, longitude: longitude)
        let christina2 = Customer(id: 12, name: "Christina McArdle", latitude: latitude, longitude: longitude)

        XCTAssertEqual(christina, christina2)
    }
}
