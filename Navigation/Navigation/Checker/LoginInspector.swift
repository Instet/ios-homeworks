//
//  LoginInspector.swift
//  Navigation
//
//  Created by Руслан Магомедов on 24.04.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        let isRight = Checker.shared.check(login: login, password: password)
        if isRight {
            return true
        } else {
            return false
        }
    }

}
