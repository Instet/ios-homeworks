//
//  Checker.swift
//  Navigation
//
//  Created by Руслан Магомедов on 24.04.2022.
//

import Foundation

final class Checker {

    static let shared = Checker()

    private let login = "Instet"

    private let password = "123456"

    func check(login: String, password: String) -> Bool {
        if login.hash == self.login.hash && password.hash == self.password.hash {
            return true
        } else {
            return false
        }
    }
    
}

