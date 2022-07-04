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
                         callback: @escaping (_ success: Bool) -> Void)

    func createUser(email: String,
                    password: String,
                    callback: @escaping (_ success: Bool) -> Void)

}

class LoginInspector: LoginViewControllerDelegate {


    func checkCredential(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        CheckerService.shared.checkCredential(email: email, password: password) { success in
            if success {
                callback(true)
            } else {
                callback(false)
            }
        }

    }

    func createUser(email: String, password: String, callback: @escaping (_ success: Bool) -> Void) {
        CheckerService.shared.createUser(email: email, password: password) { success in
            if success {
                callback(true)
            } else {
                callback(false)
            }
        }
    }




}
