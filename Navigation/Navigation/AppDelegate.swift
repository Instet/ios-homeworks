//
//  AppDelegate.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .white

        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.barTintColor = .yellow

        // MARK: NC - NavigtionController, VC - ViewController

        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .yellow
        let feedNC = UINavigationController(rootViewController: feedVC)


        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = .lightGray
        let profileNC = UINavigationController(rootViewController: profileVC)


        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear

        profileNC.navigationBar.standardAppearance = appearance
        profileNC.navigationBar.scrollEdgeAppearance = profileNC.navigationBar.standardAppearance


        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "note.text"), tag: 0)

        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))


        tabBarController.viewControllers = [feedNC, profileNC] // Массив кнопок
      

        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        

        return true
    }



}

