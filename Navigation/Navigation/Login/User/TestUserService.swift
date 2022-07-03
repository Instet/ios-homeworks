//
//  TestUserService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation
import UIKit


final class TestUserService: UserServiceProtocol {

    var user = User(name: "No Name",
                    userStatus: "Login testing",
                    userAvatar: UIImage(systemName: "person.crop.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal))


    func getUser(name: String) -> User? {
        if name == user.name {
            return user
        } else {
            return nil
        }
    }




}
