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

final class HomeViewControllerSnapshotTests: SISnapshotTest {
    func testRendering() {
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
}

