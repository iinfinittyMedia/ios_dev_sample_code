//
//  NotificationManager.swift
//  TimerCounter
//
//  Created by MDQ on 23/12/2023.
//

import SwiftUI
import UserNotifications
final class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()

    @Published var alerts = [UNNotificationRequest]()

    override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
//                self.notificationCenter.delegate = self
            } else if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }

    func scheduleNotification(title: String, body: String, trigger: UNNotificationTrigger, identifier: String = UUID().uuidString) {

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                self.alerts.append(request)
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Display the notification when the app is in the foreground
        completionHandler([.banner, .sound, .badge])
    }

    func cancelNotification(identifier: String) {
        // Cancel the notification with the specified identifier
        self.alerts.removeAll { $0.identifier == identifier }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }

}
