//
//  TimerApp.swift
//  Timer
//
//  Created by Tariq Mahmood   on 25/12/2023.
//

import SwiftUI

@main
struct TimerApp: App {
    @StateObject var viewModel = TimerViewModel()
    @Environment(\.scenePhase) var scene

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                }.onChange(of: scene) { newScene in
                    if newScene == .background {
                        viewModel.leftTime = Date()
                        addNotifications()
                    }
                    if newScene == .active && viewModel.leftTime != nil {

                        let diff = Date().timeIntervalSince(viewModel.leftTime)
                        let currentTime = viewModel.selectedTime - diff
                        if currentTime >= 0 {
                            removeNotification()
                            withAnimation(.default) {
                                viewModel.selectedTime = currentTime
                            }
                        } else {
                            viewModel.resetView()
                        }
                    }
                }
        }
    }

    private  func addNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Notification from Timer App"
        content.body = "Timer is finished!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(viewModel.selectedTime), repeats: false)
        let request = UNNotificationRequest(identifier: "TIMER", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        }
    }

   private func removeNotification() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["TIMER"])
    }
}
