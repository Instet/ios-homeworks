//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeader = ProfileHeaderView()

    let titleButton: UIButton = {
        let titleButton = UIButton()
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.setTitle("Set new title", for: .normal)
        titleButton.setTitleColor(.lightGray, for: .highlighted)
        titleButton.backgroundColor = UIColor(hex: "#027AFF")    // расширение UIColor
        titleButton.addTarget(nil, action: #selector(pressButtonTitle), for: .touchUpInside)

        return titleButton
    }()

    func setupTitleButton() {

        [titleButton.leftAnchor.constraint(equalTo: view.leftAnchor),
         titleButton.rightAnchor.constraint(equalTo: view.rightAnchor),
         titleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         titleButton.heightAnchor.constraint(equalToConstant: 50)
        ].forEach{ $0.isActive = true }

    }

    @objc func pressButtonTitle() {
       
        if profileHeader.textFieldStatus.text != "" {
            self.title = profileHeader.textFieldStatus.text
            profileHeader.textFieldStatus.text = ""
            profileHeader.textFieldStatus.resignFirstResponder()
        } else if profileHeader.textFieldStatus.text == "" {
            self.title = "New title"
            profileHeader.textFieldStatus.resignFirstResponder()

        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.addSubview(profileHeader)
        profileHeader.addView()
        self.view.addSubviews(titleButton)
        self.setupTitleButton()


    }

}



// практика
public extension UIColor {
    convenience init?(hex: String) {

        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let length = hexSanitized.count

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255
            b = CGFloat(rgb & 0x0000FF) / 255
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255
            a = CGFloat(rgb & 0x000000FF) / 255

        } else {
            return nil
        }


        self.init(red: r, green: g, blue: b, alpha: a)
    }



}
