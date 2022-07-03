//
//  LoginFactory.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation

protocol LoginFactory {

    func factory() -> LoginViewControllerDelegate

}

struct MyLoginFactory: LoginFactory {

    func factory() -> LoginViewControllerDelegate {
        return LoginInspector()
    }


}

