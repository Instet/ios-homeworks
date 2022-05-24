//
//  TestUserService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation
import UIKit


final class TestUserService: UserServiceProtocol {

    var user = User(login: "TEST",
                    fullName: "No Name",
                    userStatus: "Login testing",
                    userAvatar: UIImage(systemName: "person.crop.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal))


    func getUser(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }




}
