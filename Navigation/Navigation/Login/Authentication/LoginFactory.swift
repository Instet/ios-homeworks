//
//  LoginFactory.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
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

