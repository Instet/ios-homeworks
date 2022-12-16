//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 19.10.2022.
//

import Foundation
import UserNotifications

final class LocalNotificationsService {

    let center = UNUserNotificationCenter.current()
    private let updateID = "update"

    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        center.requestAuthorization(options: [.provisional, .sound, .badge]) { [weak self] granted, error in
            guard let self = self else { return }
            if let error = error as? UNError  {
                print(error.localizedDescription)
            }
            if granted {

                print("User has allowed notifications")
                self.center.getNotificationSettings { setting in
                    // на случай если пользователь изменит настройки
                    print(setting)
                }
                self.notificationSettings()
            } else {
                print("User has disabled notifications")
            }
        }
    }

    private func notificationSettings() {
        center.removeAllDeliveredNotifications()
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Вконтакте"
        content.sound = .default

        content.categoryIdentifier = "UPDATESAPP"

        var dataComponent = DateComponents()
        dataComponent.calendar = .current
        dataComponent.hour = 19

//        let triger = UNCalendarNotificationTrigger(dateMatching: dataComponent, repeats: true)
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: triger)
        center.add(request)
    }


    private func registerUpdatesCategory() {
        let updates = UNNotificationAction(identifier: "UPDATE", title: "Upate", options: .foreground)
        let category = UNNotificationCategory(identifier: "UPDATESAPP", actions: [updates], intentIdentifiers: [])
        center.setNotificationCategories([category])
    }

}
