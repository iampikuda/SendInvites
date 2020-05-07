//
//  HomeViewController.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit
import SnapKit

final class HomeViewController: SIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = .primary
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.alpha = 0
        return tableView
    }()

    private let findButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.graphikRegular(ofSize: 15)
        button.setTitle("Find Customers", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let topView = UIView()

    private var buttonHeight: CGFloat {
        return screenSize.height * 0.062
    }

    private let cellIdentifier = "customer-cell"

    private var animationPerformed = false

    private let viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol, screenSize: CGSize = UIScreen.main.bounds.size) {
        self.viewModel = viewModel
        super.init(screenSize: screenSize)
        self.viewModel.customerDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let navBar = navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.backgroundColor = .clear
        navBar?.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMainViews()
        setupButton()
        setupTableView()
    }

    private func setupMainViews() {
        view.addSubviews([topView, tableView])
        topView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }

        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topView.snp.bottom)
        }
    }

    private func setupButton() {
        topView.addSubview(findButton)
        findButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.centerY.centerX.equalTo(topView)
            make.width.equalTo(topView).multipliedBy(0.5)
        }

        findButton.addTarget(self, action: #selector(findButtonPressed), for: .touchUpInside)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    @objc private func findButtonPressed() {
        viewModel.findCustomers()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
            ) as? CustomerCell else {
            return UITableViewCell()
        }

        cell.bindData(customer: viewModel.getCustomer(forIndexPath: indexPath))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: CustomerDelegate {
    func customersFound() {
        self.showTableView()
    }

    func gotError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: "\(error.localizedDescription).\nPlease try again.",
            preferredStyle: .alert
        )

        let action  = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    private func showTableView() {
        if !animationPerformed {
            animationPerformed.toggle()
            self.setPreAnimationConstraints()
            self.performInitialAnimations()
        }
    }

    private func setPreAnimationConstraints() {
        self.topView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
            make.height.equalTo(buttonHeight * 2)
        }
    }

    private func performInitialAnimations() {
        if TestingService.isUnderTest { return }

        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.tableView.alpha = 1
                }

                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        self.tableView.alpha = 1
                        self.tableView.reloadData()
                        self.findButton.setTitle("Search again", for: .normal)
                    },
                    completion: { _ in
                        self.tableView.scrollToTop(animated: true)
                    }
                )
            }
        )
    }
}
