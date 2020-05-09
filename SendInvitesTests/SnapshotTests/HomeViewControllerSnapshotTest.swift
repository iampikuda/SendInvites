//
//  HomeViewControllerSnapshotTest.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SendInvites

final class HomeViewControllerSnapshotTests: SISnapshotTest, FixtureLoading {
    func test_rendering() {
        for device in self.snapshotDevices {
            let vm = HomeViewModel()
            let vc = HomeViewController(viewModel: vm, screenSize: device.screenSize)

            assertSnapshot(
                matching: vc,
                as: .image(on: device.portraitConfig),
                named: "\(String(describing: HomeViewController.self))-\(device.name)"
            )
        }
    }

    func test_rendering_withTable() {
        let customers: [Customer] = [
            Customer(id: 12, name: "Christina Ardle", latitude: 52.986375, longitude: -6.043701),
            Customer(id: 1, name: "Chris McArle", latitude: 2.986375, longitude: 6.043701),
            Customer(id: 2, name: "Tina Me", latitude: 52.375, longitude: -63.043701),
            Customer(id: 22, name: "Fristina Mardle", latitude: 22.986375, longitude: -26.043701),
            Customer(id: 122, name: "Christine Meeey", latitude: 92.986375, longitude: -56.043701),
            Customer(id: 112, name: "Rista McArdle", latitude: 12.986375, longitude: -23.041)
        ]

        for device in self.snapshotDevices {
            let vm = TestHomeViewModel(customers: customers)
            let vc = HomeViewController(viewModel: vm, screenSize: device.screenSize)

            assertSnapshot(
                matching: vc,
                as: .image(on: device.portraitConfig),
                named: "\(String(describing: HomeViewController.self))-with-table-\(device.name)"
            )
        }
    }
}

