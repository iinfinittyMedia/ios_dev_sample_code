//
//  AppDelegate.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 24/12/2023.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    //MARK: - Application Lifecycle Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Assigning UNUserNotificationCenter delegate to handle notifications
        UNUserNotificationCenter.current().delegate = self
        
        // Registering a notification category (if needed)
        let timerCategory = UNNotificationCategory(identifier: "timerCategory", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([timerCategory])
        
        // Requesting notification permissions from the user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
        
        return true
    }
    
    //MARK: - UNUserNotificationCenterDelegate Methods
    
    // Handling user interactions with notifications when app is in background or terminated
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle user interactions with notifications here
        print("Did Receive Notification")
        
        // Completion handler to let the system know that you're done processing the notification
        completionHandler()
    }
}
