//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Suleman Ali on 24/12/2023.
//

import SwiftUI

@main
struct TimerAppApp: App {
    @StateObject var viewModel = TimerViewModel(time: 10)
    @Environment(\.scenePhase) var scene

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                }
        }
    }
}
