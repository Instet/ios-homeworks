//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Руслан Магомедов on 24.04.2022.
//

import Foundation

protocol LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool

}
