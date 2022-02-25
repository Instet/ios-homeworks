//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Магомедов on 15.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {

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
        button.backgroundColor = UIColor(hex: "#027AFF")
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
        text.placeholder = "Set status or title"  // HW 2.2
        text.adjustsFontSizeToFitWidth = false // что то с клавиатурой
        text.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)



        return text
    }()

    private func setupConstraints() {

        self.translatesAutoresizingMaskIntoConstraints = false

        guard let superView = superview else { return }

        NSLayoutConstraint.activate([

            self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor),
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.heightAnchor.constraint(equalToConstant: 220),


            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),

            userName.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),

            buttonStatus.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            buttonStatus.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            buttonStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            buttonStatus.heightAnchor.constraint(equalToConstant: 50),

            statusLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: textFieldStatus.topAnchor, constant: -6),

            textFieldStatus.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            textFieldStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
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



}

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }

}
