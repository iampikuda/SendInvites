//
//  HomeViewController.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

final class HomeViewController: SIViewController {
    private let viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol, screenSize: CGSize = UIScreen.main.bounds.size) {
        self.viewModel = viewModel

        super.init(screenSize: screenSize)
    }
}
