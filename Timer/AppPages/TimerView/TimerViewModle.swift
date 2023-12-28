//
//  TimerViewModle.swift
//  Timer
//
//  Created by Tariq Mahmood   on 25/12/2023.
//

import Foundation
import Combine
import SwiftUI


class TimerViewModel: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    var time: Double = 60
    @Published var selectedTime: Double = 60
    @Published var isStartTimer = false
    @Published var progress: CGFloat = 60
    var leftTime: Date!
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        resetView()
        completionHandler()
    }

    func resetView() {
        withAnimation(.easeIn) {
            progress = time
            selectedTime = time
            isStartTimer = false
            leftTime = nil
        }
    }
    
    func onReceive(){
        if selectedTime > 0 && isStartTimer {
            selectedTime -= 0.01
            if selectedTime < 0 {
                selectedTime = 0
            }
            withAnimation(.default) {
                progress = selectedTime
            }
            if selectedTime == 0 {
                resetView()
            }
        }
    }
}
