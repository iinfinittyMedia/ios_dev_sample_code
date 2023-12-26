//
//  CountDownTimerApp.swift
//  CountDownTimer
//
//  Created by MacBook on 23/12/2023.
//

import SwiftUI

@main
struct CountDownTimerApp: App {
    
    init(){
        // Taking permission for local notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CountDownTimerView()
        }
    }
}
