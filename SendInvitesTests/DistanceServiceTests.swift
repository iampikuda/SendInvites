//
//  DistanceServiceTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class DistanceServiceTests: XCTestCase {

    func test_farAwayDistances() {
        // Apple headquaters
        XCTAssertGreaterThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 37.3230, longitude: -122.0322)),
            100
        )

        // Aso Rock
        XCTAssertGreaterThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 9.0833, longitude: 7.5361)),
            100
        )

        // Maracanã
        XCTAssertGreaterThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 22.9121, longitude: 43.2302)),
            100
        )

        // Munich
        XCTAssertGreaterThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 48.1351, longitude: 11.5820)),
            100
        )
    }

    func test_closeDistances() {
        // Ian Kehoe
        XCTAssertLessThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 53.2451, longitude: -6.2383)),
            100
        )

        // Richard Finnegan
        XCTAssertLessThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 53.00876, longitude: -6.10567)),
            100
        )

        // Christina McArdle
        XCTAssertLessThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 52.98637, longitude: -6.04370)),
            100
        )

        // Olive Ahearn
        XCTAssertLessThan(
            DistanceService.calculateDistanceTo(location: SILocation(latitude: 53, longitude: -7)),
            100
        )
    }
}
