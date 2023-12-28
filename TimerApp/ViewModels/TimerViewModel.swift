//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Suleman Ali on 25/12/2023.
//

import Foundation
import SwiftUI


class TimerViewModel: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    var totalTime: Double = 60
    @Published var selectedTime: Double = 60
    @Published var isTimerStarted = false
    @Published var isCompleted = false
    @Published var progress: CGFloat = 60
    private var timer:Timer!
    init(time: Double, isTimerStarted: Bool = false) {
        self.totalTime = time
        self.selectedTime = time
        self.isTimerStarted = isTimerStarted
        self.progress = time
        super.init()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        resetView()
        completionHandler()
    }

    //TODO: - timer logic need to update for bg
    @objc func timerTriberPoint(_ tim :Timer) {
            if self.progress > 0 && self.isTimerStarted {
                self.selectedTime -= 0.01
                if self.selectedTime < 0 {
                    self.selectedTime = 0
                }
                withAnimation(.default) {
                    self.progress = self.selectedTime
                }
                if self.selectedTime == 0 {
                    self.isCompleted = true
                    self.resetView()
                }
            }
    }

    deinit{
        self.timer?.invalidate()
    }

    func startFromZero() {
        // MARK: - we can use Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() too
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerTriberPoint), userInfo: nil, repeats: true)
    }

    func resetView() {
        withAnimation(.easeIn) {
            timer?.invalidate()
            progress = totalTime
            selectedTime = totalTime
            isTimerStarted = false
            self.isCompleted = false

        }
    }
}
