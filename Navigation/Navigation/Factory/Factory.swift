//
//  Factory.swift
//  Navigation
//
//  Created by Руслан Магомедов on 15.05.2022.
//

import Foundation
import UIKit

final class Factory {

    enum State {
        case profile
        case feed
    }

    let state: State
    let navigation: UINavigationController

    init(navigation: UINavigationController, state: State) {
        self.state = state
        self.navigation = navigation
        startModule()
    }

    

    func startModule() {
        switch state {
        case .profile:
            let coordinator = LoginCoordinator()
            let controller = coordinator.showModel(coordinator: coordinator)
            navigation.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
            navigation.setViewControllers([controller], animated: false)
            
            ()
        case .feed:
            let coordinator = FeedCoordinator()
            let controller = coordinator.showModel(coordinator: coordinator)
            navigation.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "note.text"), tag: 0)
            navigation.setViewControllers([controller], animated: false)

        }


    }
}
