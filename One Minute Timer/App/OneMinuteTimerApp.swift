//
//  One_Minute_TimerApp.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 23/12/2023.
//

import SwiftUI

@main
struct OneMinuteTimerApp: App {
    //MARK: - Properties
    
    // AppDelegate instance used to handle app-level operations
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Phase of the app's scene lifecycle
    @Environment(\.scenePhase) private var phase
    
    // TimerViewModel instance used as a dependency across the app
    @StateObject var timerViewModel = TimerViewModel()
    
    var body: some Scene {
        WindowGroup {
            // LaunchScreenView is the initial view of the app
            LaunchScreenView()
                .environmentObject(timerViewModel)
        }
        .onChange(of: phase, initial: false) { _, newPhase in
            // Reacting to changes in the app's scene phase
            
            switch newPhase {
            case .background:
                // App is going to the background
                print("App in Background ")
                timerViewModel.prepareTimeForBackground()
            case .active:
                // App is in the active state (foreground)
                timerViewModel.adjustTimerForForeground()
            case .inactive:
                // App is in an inactive state
                break
            @unknown default:
                // Handling unknown phase scenarios
                print("Unknown Default")
            }
        }
    }
}
