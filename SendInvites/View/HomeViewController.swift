//
//  HomeViewController.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit
import MessageUI
import SnapKit

final class HomeViewController: SIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = true
        tableView.bounces = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.alpha = 0
        tableView.backgroundColor = .white
        return tableView
    }()

    private let findButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.graphikBold(ofSize: 15)
        button.setTitle("Find Customers", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let emailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.primary
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.graphikBold(ofSize: 15)
        button.setTitle("Send results", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.isHidden = true
        return button
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        return stackView
    }()

    private let topView = UIView()

    private var buttonHeight: CGFloat {
        return screenSize.height * 0.062
    }

    let cellIdentifier = "customer-cell"

    private var animationPerformed = false

    let viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol, screenSize: CGSize = UIScreen.main.bounds.size) {
        self.viewModel = viewModel
        super.init(screenSize: screenSize)
        self.viewModel.customerDelegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
        setupButton()
        setupMainViews()
        setupTableView()
    }

    private func setupMainViews() {
        view.addSubviews([topView, tableView])
        if viewModel.customers.count > 0 {
            self.showTableView()
            return
        }

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
        topView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.centerY.centerX.equalTo(topView)
            make.width.equalTo(topView).multipliedBy(0.5)
        }

        buttonStackView.addArrangedSubview(findButton)
        buttonStackView.addArrangedSubview(emailButton)

        findButton.addTarget(self, action: #selector(findButtonPressed), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    @objc private func findButtonPressed() {
        self.showActivityIndicator()
        DispatchQueue.global(qos: .default).async {
            self.viewModel.findCustomers()
        }
    }

    @objc private func emailButtonPressed() {
        guard MFMailComposeViewController.canSendMail() else {
            gotError(SIError(message: "We can't send emails on this device."))
            return
        }

        let alert = UIAlertController(title: nil, message: "Input your email", preferredStyle: .alert)
        let sendAction = UIAlertAction(
            title: "Send results",
            style: .default
        ) { _ in
            guard let email = alert.textFields?[0].text else { return }
            self.sendResultsTo(email)
        }

        sendAction.isEnabled = false

        alert.addAction(sendAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { textField in
            textField.placeholder = "Email"
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: .main
                )
            { (_) in
                sendAction.isEnabled = textField.text?.isValidEmail ?? false
            }
        }

        self.present(alert, animated: true, completion: nil)
    }
}


extension HomeViewController: CustomerDelegate {
    func customersFound() {
        DispatchQueue.main.async {
            self.showTableView()
        }
    }

    func gotError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: "\(error.localizedDescription)\nPlease try again.",
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
        } else {
            self.tableView.reloadData()
            self.hideActivityIndicator()
        }
    }

    private func setPreAnimationConstraints() {
        self.topView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
            make.height.equalTo(buttonHeight * 2)
        }

        self.tableView.snp.remakeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topView.snp.bottom)
        }

        self.buttonStackView.snp.remakeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.centerY.centerX.equalTo(topView)
            make.width.equalTo(topView).multipliedBy(0.9)
        }
    }

    private func performInitialAnimations() {
        #if DEBUG
        if TestingService.isUnderTest {
            self.view.layoutIfNeeded()
            self.tableView.alpha = 1
            self.tableView.reloadData()
            self.findButton.setTitle("Search again", for: .normal)
            self.emailButton.isHidden = false
            return
        }
        #endif

        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.5,
                    animations: {
                        self.tableView.alpha = 1
                        self.tableView.reloadData()
                        self.findButton.setTitle("Search again", for: .normal)
                        self.emailButton.isHidden = false
                    }, completion: { _ in
                        self.hideActivityIndicator()
                    }
                )
            }
        )
    }
}
