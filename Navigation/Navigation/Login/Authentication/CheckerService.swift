//
//  Checker.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {

    func checkCredential(email: String,
                         password: String,
                         callback: @escaping (_ success: Bool) -> Void)

    func createUser(email: String,
                    password: String,
                    callback: @escaping (_ success: Bool) -> Void)
}

final class CheckerService: CheckerServiceProtocol {

    static let shared = CheckerService()

    private let auth = Auth.auth()

    func checkCredential(email: String,
                         password: String,
                         callback: @escaping (_ success: Bool) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            callback(result?.user != nil)
        }
    }

    func createUser(email: String,
                    password: String,
                    callback: @escaping (_ success: Bool) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            callback(result?.user != nil)
        }
    }

}

