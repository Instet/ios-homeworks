//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 14.05.2022.
//

import Foundation
import UIKit

final class ProfileCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?
    let userService: UserServiceProtocol?
    let userLogin: String?

    init(data: (userService: UserServiceProtocol, userLogin: String)) {
        self.userService = data.userService
        self.userLogin = data.userLogin
    }

    func Start() -> UINavigationController? {
        let factory = Factory(state: .profile)
        guard let userService = userService,
              let userLogin = userLogin else {
            return nil
        }
            navigationController = factory.startModule(coordinator: self, data: (userService: userService, userLogin: userLogin))
            return navigationController

    }

}


