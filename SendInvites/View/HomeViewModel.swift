//
//  HomeViewModel.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

protocol CustomerDelegate: class {
    func customersFound()
    func gotError(_ error: Error)
}

protocol HomeViewModelProtocol: class {
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    var customerDelegate: CustomerDelegate? { get set }

    func findCustomers()
    func getCustomer(forIndexPath indexPath: IndexPath) -> Customer
}

final class HomeViewModel: HomeViewModelProtocol {
    weak var customerDelegate: CustomerDelegate?

    var numberOfSections: Int {
        return 1
    }

    var numberOfRows: Int {
        return customers.count
    }

    var customers: [Customer] = []

    func getCustomer(forIndexPath indexPath: IndexPath) -> Customer {
        return customers[indexPath.row]
    }

    func findCustomers() {
        if let url = URL(string: "https://s3.amazonaws.com/intercom-take-home-test/customers.txt") {
            do {
                let stringies = try String(contentsOf: url, encoding: .utf8)
                let myStrings = stringies.components(separatedBy: .newlines)

                for line in myStrings {
                    guard let lineData = line.toData() else { continue }
                    let customer = try JSONDecoder().decode(Customer.self, from: lineData)

                    if customer.isToBeInvited {
                        customers.append(customer)
                    }
                }

                customers.sort(by: { $0.id < $1.id })
                customerDelegate?.customersFound()
            } catch let error {
                print(error.localizedDescription)
                customerDelegate?.gotError(error)
            }
        }

    }
}
