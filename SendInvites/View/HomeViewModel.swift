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
        return 15
    }

    func getCustomer(forIndexPath indexPath: IndexPath) -> Customer {
        return Customer(id: 1, name: "asd")
    }

    func findCustomers() {
        customerDelegate?.customersFound()
    }
}
