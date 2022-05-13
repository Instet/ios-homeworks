//
//  FeedViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var passwordText: String?


    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.alpha = 0
        return label
    }()

    private lazy var firstButton: CustomButton = {
        let firstButton = CustomButton(title: "First Button", titleColor: .white) { [weak self] in
            let postVC = PostViewController()
            self?.navigationController?.pushViewController(postVC, animated: true)
            self?.tabBarController?.tabBar.isHidden = true
        }
        return firstButton
    }()

    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: "Second Button", titleColor: .white) { [weak self] in
            let postVC = PostViewController()
            self?.navigationController?.pushViewController(postVC, animated: true)
            self?.tabBarController?.tabBar.isHidden = true
        }
        return secondButton
    }()

    private lazy var checkPasswordButton: PasswordCheckButton = {
        let button = PasswordCheckButton { [weak self] in
            Password.shared.check(self!.passwordText ?? "")
            self?.passwordTF.resignFirstResponder()
        }
        return button
    }()

    private lazy var passwordTF: PasswordTextField = {
        let text = PasswordTextField(delegatTF: self)
        return text
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .white
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(checkPasswordButton)
        stackView.distribution = .fillEqually
        return stackView
    }()

    private func setupConstraintsStackView() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            checkLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            checkLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.addSubviews(stackView, checkLabel)
        setupConstraintsStackView()
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordTrue), name: Notification.Name("true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordFalse), name: Notification.Name("false"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        print("будет скрыт таббар и открыта страница пост")
        tabBarController?.tabBar.isHidden = false
    }


    @objc func examinationPasswordTrue() {
        UILabel.animate(withDuration: 0.5) { [weak self] in
            self?.checkLabel.text = "Пароль верный"
            self?.checkLabel.textColor = .systemGreen
            self?.checkLabel.isHidden = false
            self?.checkLabel.alpha = 1
        } completion: { [self] _ in
            UILabel.animate(withDuration: 2) { [weak self] in
                self?.checkLabel.alpha = 0
            }
        }
        checkLabel.isHidden = false
    }


    @objc func examinationPasswordFalse() {
        UILabel.animate(withDuration: 0.5) { [weak self] in
            self?.checkLabel.text = "Пароль неверный"
            self?.checkLabel.textColor = .systemRed
            self?.checkLabel.isHidden = false
            self?.checkLabel.alpha = 1
        } completion: { [self] _ in
            UILabel.animate(withDuration: 2) { [weak self] in
                self?.checkLabel.alpha = 0
            }
        }
        checkLabel.isHidden = false
    }

}

extension FeedViewController: PasswordTextFieldDelegate {

    func enterPassword() {
        passwordText = passwordTF.text!
    }
}

