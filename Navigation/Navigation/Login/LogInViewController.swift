//
//  LogInViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 04.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    var delegate: LoginViewControllerDelegate?
    var callback: (_ userData: (userService: UserServiceProtocol, userLogin: String)) -> Void

    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        return loginScrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var imageVK: UIImageView = {
        let imageVK = UIImageView()
        imageVK.image = UIImage(named: "logo")
        return imageVK
    }()

    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()

    private lazy var loginTF: UITextField = {
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

    private lazy var passwordTF: UITextField = {
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


    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
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

    // MARK: - Task 9

    private lazy var bruteForceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(image.image(alpha: 1), for: .normal)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            button.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(bruteForceAction), for: .touchUpInside)
        return button
    }()


    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        return indicator
    }()




    init(callback: @escaping (_ userData: (userService: UserServiceProtocol, userLogin: String)) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    @objc func bruteForceAction() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        guard let login = loginTF.text else { return }
        guard login != "" else {
            let alert = UIAlertController(title: "Ошибка!",
                                          message: "Для подбора пароля введите логин: \n Instet",
                                          preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ОК",
                                            style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        queue.async {
            let bruteForce = BruteForce(loginInspector: self.delegate, login: login) { [weak self] password in
                DispatchQueue.main.async {
                    self?.passwordTF.text = password
                    self?.passwordTF.isSecureTextEntry = false
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
            bruteForce.bruteForce()
        }


    }


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
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: Constants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            bruteForceButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Constants.indent),
            bruteForceButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            bruteForceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.bottomAnchor.constraint(equalTo: loginStackView.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loginStackView.centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)


        ])
    }


    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(loginScrollView)
        loginScrollView.addSubviews(contentView)
        contentView.addSubviews(imageVK, loginStackView, loginButton, bruteForceButton, activityIndicator)
        loginStackView.addArrangedSubview(loginTF)
        loginStackView.addArrangedSubview(passwordTF)
        setupConstraints()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.becomeFirstResponder()
        loginTF.resignFirstResponder()
        passwordTF.becomeFirstResponder()
        passwordTF.resignFirstResponder()
        return true;
    }


    @objc private func pressLogIn() {

        // MARK: - TASK 11

        guard let delegate = delegate else { return }
        guard let login = loginTF.text else { return }
        guard let password = passwordTF.text else { return }

        DispatchQueue.global().async {
            self.authorization(delegate: delegate,
                               login: login,
                               password: password) { result in
                switch result {
                case .success(true):
                    DispatchQueue.main.async {
//                        #if DEBUG
                        let userService = CurrentUserService()
//                        #else
//                        let userService = TestUserService()
//                        #endif
                        self.callback((userService: userService, userLogin: login))
                    }
                case .failure(.noLogin):
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Внимание", message: "Введите логин!", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "ОК", style: .default)
                        alertVC.addAction(alertAction)
                        self.present(alertVC, animated: true)
                    }
                case .failure(.noPassword):
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Внимание", message: "Введите пароль!", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "ОК", style: .default)
                        alertVC.addAction(alertAction)
                        self.present(alertVC, animated: true)
                    }
                case .failure(.wrongDate):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Внимание", message: "Введен неверный логин или пароль!", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "ОК", style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true)
                    }
                default :
                    break

                }
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        loginTF.delegate = self
        passwordTF.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }


    @objc private func tap() {
         loginTF.resignFirstResponder()
         passwordTF.resignFirstResponder()
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
            loginScrollView.contentOffset.y = kbdSize.height - (loginScrollView.frame.height - loginButton.frame.minY) + 50
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)

        }
    }


    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

}


// MARK: - TASK 11
extension LogInViewController {

// Result
    private func authorization(delegate: LoginViewControllerDelegate?,
                               login: String,
                               password: String,
                               completion: (Result<Bool, AuthorizationErrors>) -> Void) {
        guard let delegate = delegate else { return }
        let isRight = delegate.check(login: login, password: password)
        if login.isEmpty {
            completion(.failure(.noLogin))
        }
        if password.isEmpty {
            completion(.failure(.noPassword))
        }
        if isRight{
            completion(.success(true))
        } else {
            completion(.failure(.wrongDate))
        }
    }
}
