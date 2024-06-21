//
//  NotoficationHandler.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 18.06.2024.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted")
                UserDefaults.standard.set(true, forKey: "notifications")
            } else if let error = error {
                UserDefaults.standard.setValue(false, forKey: "notifications")
                print(error.localizedDescription)
            } else {
                UserDefaults.standard.setValue(false, forKey: "notifications")
            }
        }
    }

//    func sendNotification(){
//        askPermission()
//    }
}
