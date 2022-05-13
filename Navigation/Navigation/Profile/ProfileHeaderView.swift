//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Магомедов on 15.02.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    private var statusText: String = ""
    private var defaultAvatarPoint: CGPoint?


    var userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .black
        userName.text = "Ruslan Magomedow"
        userName.textAlignment = .center
        userName.font = .systemFont(ofSize: 18, weight: .bold)
        return userName
    }()

    var avatarFoneView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .gray
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    lazy var exitAvatarButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.gray, renderingMode: .automatic), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeAvatarView), for: .touchUpInside)
        return button
    }()

    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "гомер")
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 3
        avatar.layer.cornerRadius = 50
        avatar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        var gesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapAvatar))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        avatar.addGestureRecognizer(gesture)
        avatar.isUserInteractionEnabled = true
        return avatar
    }()

    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var buttonStatus: UIButton = {
        let button = UIButton()
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
        text.backgroundColor = .white
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.cornerRadius = 12
        text.layer.borderWidth = 1
        text.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        text.placeholder = "Set status"
        text.adjustsFontSizeToFitWidth = false
        text.addTarget(ProfileHeaderView.self, action: #selector(statusTextChanged), for: .editingChanged)



        return text
    }()

    private func setupConstraints() {

        avatar.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(self.snp.topMargin).offset(Constants.indent)
            make.left.lessThanOrEqualTo(Constants.leadingMargin)
        }

        userName.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(self.snp.topMargin).offset(27)
        }

        buttonStatus.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(Constants.indent)
            make.left.right.equalTo(self.snp.horizontalEdges).inset(Constants.indent)
            make.height.equalTo(50)
        }

        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalTo(self.snp.rightMargin).offset(Constants.trailingMargin)
            make.bottom.equalTo(textFieldStatus.snp.top).offset(-6)
        }

        textFieldStatus.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.equalTo(avatar.snp.rightMargin).offset(20)
            make.right.equalTo(self.snp.rightMargin).offset(Constants.trailingMargin)
            make.bottom.equalTo(buttonStatus.snp.top).offset(-10)
        }

        exitAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(Constants.indent)
            make.width.height.equalTo(40)
            make.right.equalTo(contentView.snp.right).offset(Constants.trailingMargin)
        }

    }

    func addView() {
        addSubviews(userName, statusLabel, buttonStatus, textFieldStatus, avatarFoneView, avatar, exitAvatarButton)
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


    @objc  func didTapAvatar() {
        UIImageView.animate(withDuration: 0.5) {
            self.defaultAvatarPoint = self.avatar.center
            self.avatar.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - self.avatar.center.y)
            self.avatar.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatar.frame.width, y: self.contentView.frame.width / self.avatar.frame.width)
            self.avatar.layer.cornerRadius = 0
            self.avatarFoneView.isHidden = false
            self.avatarFoneView.alpha = 0.9
            ProfileViewController.postTableView.isScrollEnabled = false
            ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
            self.avatar.isUserInteractionEnabled = false
        } completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.exitAvatarButton.alpha = 1

            }

        }

    }



    @objc func closeAvatarView() {
        UIImageView.animate(withDuration: 0.3) {
            self.exitAvatarButton.alpha = 0
        } completion: { _ in
            UIImageView.animate(withDuration: 0.5) {

                guard self.defaultAvatarPoint != nil else { return }
                self.avatar.center = self.defaultAvatarPoint!
                self.avatar.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
                self.avatarFoneView.alpha = 0
                ProfileViewController.postTableView.isScrollEnabled = true
                ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
                self.avatar.isUserInteractionEnabled = true

            }
        }

    }

}




