//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Магомедов on 15.02.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    private var statusText: String = ""

    var userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .black
        userName.text = "Ruslan Magomedow"
        userName.textAlignment = .center
        userName.font = .systemFont(ofSize: 18, weight: .bold)
        return userName
    }()

    var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage(named: "гомер")
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 3
        avatar.layer.cornerRadius = 50
        avatar.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return avatar
    }()

    var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var buttonStatus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hex: "#4885CC")
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(nil, action: #selector(pressButton), for: .touchUpInside)


        return button
    }()

    var textFieldStatus: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.cornerRadius = 12
        text.layer.borderWidth = 1
        text.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        text.placeholder = "Set status"  // HW 2.2
        text.adjustsFontSizeToFitWidth = false // что то с клавиатурой
        text.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)



        return text
    }()

    private func setupConstraints() {

        NSLayoutConstraint.activate([

            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.indent),

            userName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),

            buttonStatus.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Constants.indent),
            buttonStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingMargin),
            buttonStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingMargin),
            buttonStatus.heightAnchor.constraint(equalToConstant: 50),

            statusLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: Constants.trailingMargin),
            statusLabel.bottomAnchor.constraint(equalTo: textFieldStatus.topAnchor, constant: -6),

            textFieldStatus.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20),
            textFieldStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingMargin),
            textFieldStatus.bottomAnchor.constraint(equalTo: buttonStatus.topAnchor, constant: -10),
            textFieldStatus.heightAnchor.constraint(equalToConstant: 40),

        ] )

    }

    func addView() {
        addSubviews(userName, avatar, statusLabel, buttonStatus, textFieldStatus)
        self.setupConstraints()
    }


    @objc func pressButton() {
        if textFieldStatus.text != "" {
            statusLabel.text = textFieldStatus.text
            textFieldStatus.text = ""
            textFieldStatus.resignFirstResponder()
        } else if textFieldStatus.text == "" {
            textFieldStatus.resignFirstResponder()

        }

    }

    func maxLenghtTextField(){
        let maxChar = 24
        if (textFieldStatus.text?.count) != nil {
            if textFieldStatus.text!.count == maxChar {
                textFieldStatus.deleteBackward()
            }
        }
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
        maxLenghtTextField()
        print(statusText)
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
