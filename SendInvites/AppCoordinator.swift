//
//  AppCoordinator.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

final class AppCoordinator {

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    final func startApp() {
        let vm = HomeViewModel()
        let vc = HomeViewController(viewModel: vm)

        let navController = UINavigationController(rootViewController: vc)

        self.window.rootViewController = navController
    }
}
