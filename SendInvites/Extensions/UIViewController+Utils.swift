//
//  UIViewController+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

extension UIViewController {
    func showActivityIndicator() {
        // Prevent multiple activity indicators from being added to the view
        guard view.viewWithTag(UIConstants.activityTag.rawValue) == nil else {
            return
        }

        let activityIndicator = SIActivityIndicatorView()
        activityIndicator.tag = UIConstants.activityTag.rawValue
        self.view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }

        activityIndicator.startAnimating()
        activityIndicator.isUserInteractionEnabled = true
        self.view.layoutIfNeeded()
        self.view.isUserInteractionEnabled = false
    }

    func hideActivityIndicator() {
        view.isUserInteractionEnabled = true

        if let activityIndicator = view.viewWithTag(UIConstants.activityTag.rawValue) {
            activityIndicator.removeFromSuperview()
        }
    }
}
