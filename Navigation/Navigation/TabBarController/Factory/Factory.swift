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
        case music
        case video
        case dictaphone
        case favoritesPost
    }

    let state: State


    init(state: State) {
        self.state = state
    }

    func startModule(coordinator: CoordinatorViewController, data: (userService: UserServiceProtocol, userLogin: String)?) -> UINavigationController? {
        switch state {
        case .profile:
            guard let userDate = data else { return nil }
            let profileViewModel = ProfileViewModel()
            let profileVC = ProfileViewController(coordinator: coordinator as? ProfileCoordinator, viewModel: profileViewModel, userService: userDate.userService, userLogin: userDate.userLogin)
            let profileNC = UINavigationController(rootViewController: profileVC)
            profileNC.tabBarItem = UITabBarItem(title: "Profile",
                                                image: UIImage(systemName: "person.crop.circle"),
                                                selectedImage: UIImage(systemName: "person.crop.circle.fill"))
            return profileNC

        case .feed:
            let feedViewModel = FeedViewModel()
            let feedVC = FeedViewController(coordinator: coordinator as? FeedCoordinator, viewModel: feedViewModel)
            feedVC.view.backgroundColor = .white
            let feedNC = UINavigationController(rootViewController: feedVC)
            feedNC.tabBarItem = UITabBarItem(title: "Feed",
                                             image: UIImage(systemName: "note.text"),
                                             tag: 0)
            return feedNC

        case .music:
            let viewModel = AudioViewModel()
            let mediaVC = AudioViewController(coordinator: coordinator as? AudioCoordinator, viewModel: viewModel)
            mediaVC.view.backgroundColor = .white
            let mediaNC = UINavigationController(rootViewController: mediaVC)
            mediaNC.tabBarItem = UITabBarItem(title: "Music",
                                              image: UIImage(systemName: "play"),
                                              selectedImage: UIImage(systemName: "play.fill"))
            return mediaNC
            
        case .video:
            let viewModel = VideoViewModel()
            let videoVC = VideoViewController(coordinator: coordinator as? VideoCoordinator, viewModel: viewModel)
            videoVC.view.backgroundColor = .white
            let videoNC = UINavigationController(rootViewController: videoVC)
            videoNC.tabBarItem = UITabBarItem(title: "Video",
                                              image: UIImage(systemName: "tv"),
                                              selectedImage: UIImage(systemName: "tv.fill"))
            return videoNC

        case .dictaphone:
            let dictaphoneVC = DictaphoneViewController(coordinator: coordinator as? DictaphoneCoordinator)
            dictaphoneVC.view.backgroundColor = .white
            let dictaphoneNC = UINavigationController(rootViewController: dictaphoneVC)
            dictaphoneNC.tabBarItem = UITabBarItem(title: "Dictaphone",
                                                   image: UIImage(systemName: "record.circle"),
                                                   selectedImage: UIImage(systemName: "record.circle.fill"))


            return dictaphoneNC

        case .favoritesPost:
            let favoritesVC = FavoritesViewController(coordinator: coordinator as? FavoritesCoordinator)
            favoritesVC.view.backgroundColor = .white
            favoritesVC.title = "My favorite posts"
            let favoritesNC = UINavigationController(rootViewController: favoritesVC)
            favoritesNC.tabBarItem = UITabBarItem(title: "Favorites",
                                                  image: UIImage(systemName: "star"),
                                                  selectedImage: UIImage(systemName: "star.fill"))

            return favoritesNC
        }
    }

}
