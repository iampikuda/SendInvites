//
//  SIActivityIndicatorView.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 09/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit
import SnapKit

final class SIActivityIndicatorView: UIView {
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        clipsToBounds = true

        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.centerX.centerY.equalToSuperview()
        }
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
