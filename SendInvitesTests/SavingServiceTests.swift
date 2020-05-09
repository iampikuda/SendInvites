//
//  SavingServiceTests.swift
//  SendInvitesTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import XCTest

@testable import SendInvites

final class SavingServiceTests: XCTestCase {
    func test_customersToString() {
        let writeCustomers = [
            Customer(id: 1, name: "First Person", latitude: 10, longitude: 10),
            Customer(id: 2, name: "Second Person", latitude: 44, longitude: 44)
        ]

        let readCustomers = "{\"latitude\":\"10.0\",\"longitude\":\"10.0\",\"name\":\"First Person\",\"user_id\":1}\n{\"latitude\":\"44.0\",\"longitude\":\"44.0\",\"name\":\"Second Person\",\"user_id\":2}"

        do {
            let customerString = try SavingService.customersToString(data: writeCustomers)

            XCTAssertEqual(customerString, readCustomers)

        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func test_savingCustomersToFile() {
        let writeCustomers = [
            Customer(id: 1, name: "First Person", latitude: 10, longitude: 10),
            Customer(id: 2, name: "Second Person", latitude: 44, longitude: 44)
        ]

        var readCustomers: [Customer] = []

        do {
            let fileURL = try SavingService.saveDataToFile(data: writeCustomers, fileName: "TestingSave")
            let dataString = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = dataString.components(separatedBy: .newlines)

            for line in lines {
                guard let lineData = line.toData() else { continue }
                let customer = try JSONDecoder().decode(Customer.self, from: lineData)

                readCustomers.append(customer)
            }

            readCustomers.sort(by: { $0.id < $1.id })

            XCTAssertEqual(writeCustomers[0], readCustomers[0])
            XCTAssertEqual(writeCustomers[1], readCustomers[1])

        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
