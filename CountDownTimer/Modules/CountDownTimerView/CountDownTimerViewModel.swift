//
//  CountDownTimerViewModel.swift
//  CountDownTimer
//
//  Created by MacBook on 23/12/2023.
//

import SwiftUI
import Combine

let MILISECOND = 0.001

class CountdownTimerViewModel: ObservableObject {
    // These will be used to store the current value of
    // the unit on the clock, which then notifies the view
    // of a change to display when the original value is updated
    // progress: variable to identify the circular progress bar
    @Published var progress:Double = 0.0
    // dateValue: to be shown on time counter
    @Published var dateValue:String = ""
    @Published var miliseconds:Int = 0
    var initialTimeRemaining = 0.0
    let milisecondMaxValue = 999
    let progressMaxValue:Double = 100
    var endDate: Date = Date()
    //Updating after every milisconds
    @Published var timer = Timer.publish(every: MILISECOND, on: .main, in: .common).autoconnect()
    @Published var shouldStartCountDown = false
    @Published var isPaused = false
    var oldProgressValue = 0
    
    var hasCountdownCompleted: Bool {
        Date() > endDate && shouldStartCountDown
    }
    
    init() {
        self.timer.upstream.connect().cancel()
        self.endDate = Date.dateByAddingMinute
        self.initialTimeRemaining = endDate.timeIntervalSinceNow
        updateTimer()
    }
    
    // This function is mainly responsible for the date and progress values inside the time counter
    func updateTimer() {
        let components = Date.componentsFromDate(endDate: endDate)
        if !hasCountdownCompleted, let date = Date.dateFromComponents(components: components){
            if miliseconds == milisecondMaxValue{
                miliseconds = 0
            } else {
                miliseconds = miliseconds + 1
            }
            dateValue = date.timeString
            progress = Double(endDate.timeIntervalSinceNow / initialTimeRemaining)
        } else {
            progress = progressMaxValue
            miliseconds = 0
        }
    }
    
    func setDefaults(){
        miliseconds = 0
        progress = 0
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        miliseconds = 0
        progress = 1
        shouldStartCountDown = false
        self.endDate = Date.dateByAddingMinute
        self.initialTimeRemaining = endDate.timeIntervalSinceNow
        let components = Date.componentsFromDate(endDate: self.endDate)
        if let date = Date.dateFromComponents(components: components){
            dateValue = date.timeString
            progress = Double(endDate.timeIntervalSinceNow / initialTimeRemaining)
        }
        cancelAllNotifications()
    }
    
    func stopTimerAutomatically() {
        self.timer.upstream.connect().cancel()
        miliseconds = 0
        progress = 1
        shouldStartCountDown = false
        cancelAllNotifications()
    }
    
    /*
    func pauseTimer() {
        isPaused = true
        shouldStartCountDown = false
        self.timer.upstream.connect().cancel()
    }*/
    
    func startTimer() {
        /*
        if isPaused{
            let seconds = 60 * progress
            self.endDate = Date.dateByAdding(seconds: Int(seconds))
            self.initialTimeRemaining = endDate.timeIntervalSinceNow
        } else if !isPaused{
            */
        if !shouldStartCountDown{
            self.endDate = Date.dateByAddingMinute
            self.initialTimeRemaining = endDate.timeIntervalSinceNow
            //        }
            shouldStartCountDown = true
            self.timer = Timer.publish(every: MILISECOND, on: .main, in: .common).autoconnect()
            scheduleLocalNotification()
        }
    }
    
    // Scheduling notification for timer once completed
    func scheduleLocalNotification(){
        cancelAllNotifications()
        let content = UNMutableNotificationContent()
        content.title =  "Count down timer"
        content.subtitle = "Timer is over"
        content.sound = UNNotificationSound.default
        
        // show this notification at 7.30 everyday
//            let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: false)
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: "abcd\(NSDate().timeIntervalSince1970)", content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAllNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
