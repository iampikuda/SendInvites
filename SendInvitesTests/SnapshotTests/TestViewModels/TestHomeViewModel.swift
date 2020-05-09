//
//  TestHomeViewModel.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

@testable import SendInvites

final class TestHomeViewModel: HomeViewModel {
    convenience init(customers: [Customer]) {
        self.init()
        self.customers = customers
    }
}
