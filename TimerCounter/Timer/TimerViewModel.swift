//
//  TimerViewModel.swift
//  TimerCounter
//
//  Created by MDQ on 23/12/2023.
//

import SwiftUI
import Combine
import UserNotifications

protocol TimerViewModel: ObservableObject { // Dependency Inversion Principle
    var timeRemaining: TimeInterval { get set }
    var isRunning: Bool { get set }

    func getTimeString() -> String
}

class TimerViewModelImplement: TimerViewModel {
    @Published var timeRemaining: TimeInterval = 60
    @Published var isRunning: Bool = false

    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    private var startDate: Date? { didSet { saveRunningTime() } }

    init() {
        $isRunning
            .sink { [weak self] isRunning in
                if isRunning {
                    self?.startTimer()
                } else {
                    self?.stopTimer()
                }
            }
            .store(in: &cancellables)
        registerNotificationAfterTime()
        registerNotificationForBackGround()
    }

    func getTimeString() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        let milliseconds = Int((timeRemaining - Double(Int(timeRemaining))) * 100)

        return String(format: "%02d : %02d : %02d", minutes, seconds, milliseconds)
    }

    private func registerNotificationAfterTime() {
        // Request notification permission when the app starts
        NotificationManager.shared.requestAuthorization()
    }

    private func registerNotificationForBackGround() {
        // Listen for app entering the background
        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in
                print("Notification Triger for")
                self?.scheduleNotification()
                self?.saveRunningTime()
            }
            .store(in: &cancellables)
    }

    private func startTimer() {
        startDate = fetchRunningTime()
        if startDate == nil {
            startDate = Date()
        }
        scheduleNotification()
        print("Start timer called")
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let startDate = self?.startDate else { return }
            let elapsed = abs(Date().timeIntervalSince(startDate))
            self?.timeRemaining = max(0, (self?.timeRemaining ?? 0) - elapsed)
            if (self?.timeRemaining ?? 0) <= 0 {
                self?.isRunning = false
                self?.timeRemaining = 60
                self?.startDate = nil
                return
            }
            self?.startDate = Date()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        if let startDate = startDate {
            let elapsed = abs(Date().timeIntervalSince(startDate))
            timeRemaining -= elapsed
            if self.timeRemaining <= 0 {
                self.timeRemaining = 60
                // Assume that button time is over now
                NotificationManager.shared.cancelNotification(identifier: Keys.ontMinuteNotification)
            } else {
                // Assume that button pressed by the user and stop it so cancelNotification()
                NotificationManager.shared.cancelNotification(identifier: Keys.ontMinuteNotification)
            }
        } else { // running Timmer does not have any value so restart all the things
            self.timeRemaining = 60
            NotificationManager.shared.cancelNotification(identifier: Keys.ontMinuteNotification)
        }
        startDate = nil
    }

    private func scheduleNotification() {
        NotificationManager.shared.cancelNotification(identifier: Keys.ontMinuteNotification)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeRemaining, repeats: false)
        NotificationManager.shared.scheduleNotification(title: "Timer Complete", body: "Your timer has finished.", trigger: trigger, identifier: Keys.ontMinuteNotification)
    }

    private func saveRunningTime() {
        if let startTime = startDate {
            UserDefaults.runningTime = startTime
        } else {
            UserDefaults.runningTime = nil
        }
    }

    private func fetchRunningTime() -> Date? {
        UserDefaults.runningTime
    }
}
