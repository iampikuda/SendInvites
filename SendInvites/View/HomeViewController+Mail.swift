//
//  HomeViewController+Mail.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit
import MessageUI

extension HomeViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true) {
            self.completeWithResult(result, error: error)
        }
    }

    private func completeWithResult(_ result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
        case .failed:
            gotError(error ?? SIError(message: "We couldn't send the mail."))
        case .saved:
            mailSucceed(with: "Mail saved.")
        case .sent:
            mailSucceed(with: "Mail sent.")
        @unknown default:
            gotError(error ?? SIError(message: "We couldn't send the mail."))
        }
    }

    private func mailSucceed(with message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )

        let action  = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }

    func sendResultsTo(_ email: String) {
        do {
            let textFileURL = try SavingService.saveDataToFile(data: viewModel.customers)

            let mail = MFMailComposeViewController()
            mail.setToRecipients([email])
            mail.setSubject("Customers 100km away from dublin office")
            mail.mailComposeDelegate = self

            do {
                let customerData = try Data(contentsOf: textFileURL)
                mail.addAttachmentData(customerData, mimeType: ".txt", fileName: "Output")
                self.present(mail, animated: true, completion: nil)
            } catch let error {
                gotError(error)
            }
        } catch let error {
            gotError(error)
        }
    }
}
