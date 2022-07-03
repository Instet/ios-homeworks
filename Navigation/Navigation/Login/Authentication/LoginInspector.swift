//
//  LoginInspector.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {

    func checkCredential(email: String,
                         password: String,
                         callback: @escaping (Result<AuthModel, AuthorizationError>) -> Void)

    func createUser(email: String,
                    password: String,
                    callback: @escaping (Result<AuthModel, AuthorizationError>) -> Void)

}

class LoginInspector: LoginViewControllerDelegate {


    func checkCredential(email: String, password: String, callback: @escaping (Result<AuthModel, AuthorizationError>) -> Void) {
        ()

    }

    func createUser(email: String, password: String, callback: @escaping (Result<AuthModel, AuthorizationError>) -> Void) {
        ()
    }




}
