//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 19.04.2022.
//

import Foundation
import UIKit

protocol UserService {

    func getUser(login: String) -> User?

}


final class CurrentUserService: UserService {

    var user = User(login: "Instet",
                    fullName: "Ruslan Magomedow",
                    userStatus: "Glück ist immer mit mir",
                    userAvatar: UIImage(named: "гомер"))

    func getUser(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }

}
