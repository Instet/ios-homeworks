//
//  AppDelegate.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit
import AVFoundation
import YoutubePlayer_in_WKWebView
import Foundation
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let coordinator: GeneralCoordinator = RootCoordinator()
        
//        NetworkManager.shared.getDataAll()

        FirebaseApp.configure()
        

        let notificationService = LocalNotificationsService()
        notificationService.center.delegate = self
        notificationService.registeForLatestUpdatesIfPossible()

        appendArrayPhotos()
        self.window?.rootViewController = coordinator.startApplication(userData: nil, stateAuthorization: .notAuthorized)

        return true
    }



    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.categoryIdentifier == "UPDATESAPP" {
            switch response.actionIdentifier {
            case "UPDATE":
                print("🔴Обновление🔴")
            default:
                break
            }
        }
        completionHandler()
    }

}

