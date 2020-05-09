//
//  SavingService.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import Foundation

struct SavingService {
    static func saveDataToFile(data: [Customer], fileName: String = "Output") throws -> URL {
        let fileType = "txt"
        
        let DocumentDirURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )

        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileType)
        print("FilePath: \(fileURL.path)")

        do {
            let writeString = try customersToString(data: data)
            try writeString.write(to: fileURL, atomically: true, encoding: .utf8)

            return fileURL
        } catch let error {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
            throw(error)
        }
    }

    static func customersToString(data: [Customer]) throws -> String {
        var customersString: [String] = []

        for customer in data {
            customersString.append(try customer.asDictionary().asJsonString)
        }

        return customersString.reduce("") { (existing, next) -> String in
            if existing == "" {
                return next
            } else {
                return "\(existing)\n\(next)"
            }
        }

    }
}
