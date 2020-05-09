//
//  FixtureLoading.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 08/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

@testable import SendInvites

enum FileName: String {
    case sampleCustomerFile = "customers"
}

enum FileType: String {
    case txt = "txt"
}

protocol FixtureLoading {}

extension FixtureLoading {
    private func makeFileMissingError(filename: FileName) -> Error {
        return SIError(message: "File \(filename.rawValue) not found in test bundle")
    }

    public func loadCustomerFrom(filename: FileName, fileType: FileType, callingClass: AnyObject) throws -> [Customer] {
        var customers: [Customer] = []

        let testBundle = Bundle(for: type(of: callingClass))
        if let path = testBundle.path(forResource: filename.rawValue, ofType: fileType.rawValue) {
            let dataString = try String(contentsOfFile: path, encoding: .utf8)
            let lines = dataString.components(separatedBy: .newlines)
            for line in lines {
                guard let lineData = line.toData() else { continue }
                let customer = try JSONDecoder().decode(Customer.self, from: lineData)
                customers.append(customer)
            }

            return customers.sorted(by: { $0.id < $1.id })
        } else {
            throw(self.makeFileMissingError(filename: filename))
        }
    }
}
