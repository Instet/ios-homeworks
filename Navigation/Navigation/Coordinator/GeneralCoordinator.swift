//
//  GeneralCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 14.05.2022.
//

import Foundation
import UIKit

enum StateAuthorization {
    case authorized
    case notAuthorized
}


protocol GeneralCoordinator: AnyObject {

    func startApplication(userData: (userService: UserServiceProtocol, userLogin: String)?, stateAuthorization: StateAuthorization) -> UIViewController

}

protocol CoordinatorViewController: AnyObject {
    var navigationController: UINavigationController? { get set }
    func Start() throws -> UINavigationController?
}

class RootCoordinator: GeneralCoordinator {

    func startApplication(userData: (userService: UserServiceProtocol, userLogin: String)?, stateAuthorization: StateAuthorization) -> UIViewController {
        let tabBarcontroller = MainTabBarController(coordinator: self, stateAuthorization: .notAuthorized, userData: userData)
        tabBarcontroller.tabBar.standardAppearance.backgroundColor = .createColor(lightMod: .systemGray6, darkMod: .black)

            return tabBarcontroller
        }

}
