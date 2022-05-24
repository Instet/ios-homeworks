//
//  Checker.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation

final class Checker {

    static let shared = Checker()

    private let login = "Instet"

    private let password = "3009"

    func check(login: String, password: String) -> Bool {
        if login.hash == self.login.hash && password.hash == self.password.hash {
            return true
        } else {
            return false
        }
    }

}
