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
        self.window?.makeKeyAndVisible()
        let coordinator: GeneralCoordinator = RootCoordinator()
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().barStyle = .default
  


        appendArrayPhotos()
        self.window?.rootViewController = coordinator.startApplication(userData: nil)



        return true
    }



}
