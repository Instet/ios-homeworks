//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation
import UIKit

protocol UserServiceProtocol: AnyObject {

    func getUser(login: String) -> User?

}


final class CurrentUserService: UserServiceProtocol {

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
