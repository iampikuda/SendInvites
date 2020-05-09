//
//  CustomerCell.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit
import SnapKit

final class CustomerCell: UITableViewCell {

    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.font = UIFont.graphikRegular(ofSize: 15)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.font = UIFont.graphikRegular(ofSize: 15)
        return label
    }()

    private let cellContentView = UIView()

    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        nameLabel.text = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none

        setupCell()
        setupLabels()
    }

    private func setupCell() {
        cellContentView.clipsToBounds = true
        cellContentView.backgroundColor = .white
        addSubview(cellContentView)
        cellContentView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.8)
        }
    }

    private func setupLabels() {
        cellContentView.addSubviews([idLabel, nameLabel])
        idLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(cellContentView)
            make.width.equalTo(cellContentView).multipliedBy(0.2)
        }

        nameLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(cellContentView)
            make.left.equalTo(idLabel.snp.right)
        }
    }

    func bindData(customer: Customer) {
        idLabel.text = "\(customer.id)"
        nameLabel.text = "\(customer.name) (\(customer.distanceFromOffice.rounded(.up))km)"
    }
}
