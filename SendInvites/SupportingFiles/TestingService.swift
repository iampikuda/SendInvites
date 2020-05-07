//
//  TestingService.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct TestingService {
    static var isUnderTest: Bool = {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil ||
            CommandLine.arguments.contains("--uitesting") {
            return true
        }
        #endif
        return false
    }()
}
