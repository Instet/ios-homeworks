//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 14.05.2022.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {

    private let profile = Factory(navigation: UINavigationController(), state: .profile)

    private let feed = Factory(navigation: UINavigationController(), state: .feed)

    override func viewDidLoad() {
        super.viewDidLoad()
        controllers()
    }

    func controllers() {
        viewControllers = [profile.navigation,
                           feed.navigation]
    
    }
}
