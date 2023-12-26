//
//  LaunchScreenView.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 24/12/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    //MARK: - Properties
    
    // Accessing the TimerViewModel as an environment object
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    // State properties to control view activation, size, and opacity changes
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            // Displaying TimerView if 'isActive' is true, once launch view is displayed else LaunchView
            if isActive {
                TimerView(viewModel: timerViewModel)
            } else {
                LaunchView()
            }
        }
        .onAppear {
            // Triggering the view activation after a delay of 2.0 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true // Activating the view with animation
                }
            }
        }
    }
}

//MARK: - Preview

#Preview {
    LaunchScreenView() // Previewing the LaunchScreenView
}
