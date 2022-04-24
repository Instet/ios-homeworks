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
        tabBarController.tabBar.backgroundColor = .clear

        let feedVC = FeedViewController()
        feedVC.view.backgroundColor = .white
        let feedNC = UINavigationController(rootViewController: feedVC)

        let loginInspector = LoginInspector()
        let logIn = LogInViewController()
        logIn.delegate = loginInspector

        logIn.view.backgroundColor = .white
        let profileNC = UINavigationController(rootViewController: logIn)
        logIn.navigationController?.navigationBar.isHidden = true

        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "note.text"), tag: 0)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        tabBarController.viewControllers = [profileNC, feedNC]
        appendArrayPhotos()

        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()


        return true
    }



}
