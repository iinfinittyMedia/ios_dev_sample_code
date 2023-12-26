//
//  CountdownTimerViewModel.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 23/12/2023.
//
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    //MARK: - Published Properties
    @Published var timeRemaining: TimeInterval = 60 // 1 minute in seconds
    
    //MARK: - Class Properties
    private var cancellables = Set<AnyCancellable>()
    private var timerPublisher: AnyPublisher<Date, Never> {
        Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
    private var isTimerRunning = false
    private var timerCancellable: AnyCancellable?
    private var backgroundTime: Date?
    private var accumulatedTimeInBackground: TimeInterval = 0
    
    init() {
        setupTimer()
    }
    
    //MARK: - Timer Setup
    
    private func setupTimer() {
        timerPublisher
            .sink { _ in
                if self.isTimerRunning && self.timeRemaining > 0 {
                    self.timeRemaining -= 0.01
                } else if self.timeRemaining <= 0 {
                    self.stopTimer()
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Timer Controls
    
    func startTimer() {
        isTimerRunning = true
    }
    
    func pauseTimer() {
        isTimerRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func stopTimer() {
        isTimerRunning = false
        timeRemaining = 60
        cancelScheduledNotification()
    }
    
    //MARK: - Background Timer methods
    
    func prepareTimeForBackground() {
        backgroundTime = Date()
        pauseTimer()
        scheduleNotification()
    }
    
    func adjustTimerForForeground() {
        guard let backgroundTime = backgroundTime else { return }
        let backgroundDuration = Date().timeIntervalSince(backgroundTime)
        
        accumulatedTimeInBackground += backgroundDuration
        let remainingTime = timeRemaining - accumulatedTimeInBackground
        
        if remainingTime > 0 {
            timeRemaining = remainingTime
        } else {
            timeRemaining = 0
        }
        
        startTimer()
        self.backgroundTime = nil
    }
    
    //MARK: - Trigger Notification
    
    func scheduleNotification() {
        guard timeRemaining > 0 else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Timer Ended"
        content.body = "Your timer has finished!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeRemaining, repeats: false)
        
        let request = UNNotificationRequest(identifier: "OMTtimerEndedIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Timer notification scheduled for \(self.timeRemaining) seconds from now")
            }
        }
    }
    
    func cancelScheduledNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["OMTtimerEndedIdentifier"])
    }
}
