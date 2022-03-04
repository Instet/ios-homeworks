//
//  LogInViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 04.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    var isLogIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        loginTF.delegate = self
        passwordTF.delegate = self
        self.navigationController?.navigationBar.isHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc private func keyboardShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = kbdSize.height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)

            print(kbdSize.height)
            print(loginScrollView.frame.height - loginButton.frame.minY)
            print( loginScrollView.contentOffset.y)
        }

    }

    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.becomeFirstResponder()
        loginTF.resignFirstResponder()
        passwordTF.becomeFirstResponder()
        passwordTF.resignFirstResponder()
        return true;
    }


    var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        loginScrollView.translatesAutoresizingMaskIntoConstraints = false
        return loginScrollView
    }()

    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    var imageVK: UIImageView = {
        let imageVK = UIImageView()
        imageVK.image = UIImage(named: "logo")
        imageVK.translatesAutoresizingMaskIntoConstraints = false
        return imageVK
    }()

    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()

    var loginTF: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Email or phone"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()

    var passwordTF: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()

    var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        if let image = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }

        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(pressLogIn), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        return loginButton

    }()


    private func setupConstraints() {
        NSLayoutConstraint.activate([

            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),

            imageVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageVK.heightAnchor.constraint(equalToConstant: 100),
            imageVK.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }


    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(imageVK, loginStackView, loginButton)
        loginStackView.addArrangedSubview(loginTF)
        loginStackView.addArrangedSubview(passwordTF)
        setupConstraints()
    }


    @objc private func pressLogIn() {
        isLogIn = true
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: false)

        if isLogIn {
            navigationController?.setViewControllers([profileVC], animated: true)
            profileVC.navigationController?.navigationBar.isHidden = false
        }
    }

    @objc func tap() {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }


}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
