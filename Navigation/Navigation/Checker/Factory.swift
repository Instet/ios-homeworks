//
//  LoginFactory.swift
//  Navigation
//
//  Created by Руслан Магомедов on 24.04.2022.
//

import Foundation

protocol LoginFactory {

    func factory() -> LoginInspector

}

struct MyLoginFactory: LoginFactory {

    func factory() -> LoginInspector {
        return LoginInspector()
    }


}
