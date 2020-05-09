//
//  TableHeaderView.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

final class TableHeaderView: UIView {
    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.font = UIFont.graphikBold(ofSize: 15)
        label.text = "ID"
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.font = UIFont.graphikBold(ofSize: 15)
        label.text = "Name"
        return label
    }()

    private let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        clipsToBounds = true
        addSubview(contentView)
        backgroundColor = .white
        contentView.snp.makeConstraints { make in
            make.top.bottom.centerX.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
        }

        self.addBottomBorder(with: .black, andWidth: 2)

        contentView.addSubviews([idLabel, nameLabel])
        idLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.2)
        }

        nameLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(contentView)
            make.left.equalTo(idLabel.snp.right)
        }
    }
}
