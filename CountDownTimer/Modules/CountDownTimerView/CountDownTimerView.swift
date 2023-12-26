//
//  ContentView.swift
//  CountDownTimer
//
//  Created by MacBook on 23/12/2023.
//

import SwiftUI
import UserNotifications

struct CountDownTimerView: View {
    // View model for count down timer view
    @StateObject var viewModel: CountdownTimerViewModel
    let timerWidth:CGFloat = 200
    let timerHeight:CGFloat = 200
    let topPadding:CGFloat = 100
    let buttonsSpacing:CGFloat = 10.0
    let vStackSpacing:CGFloat = 10.0
    var date = Date()
    
    init() {
        // Dependency injection to initialize the CountdownTimerViewModel
        _viewModel = StateObject(wrappedValue: CountdownTimerViewModel())
    }
    
    var body: some View {
        VStack(spacing: vStackSpacing) {
            ZStack {
                ProgressView(progress: viewModel.progress)
                Text("\(viewModel.dateValue):\(viewModel.miliseconds)")
                    .font(Font.timerFont)
            }
            .frame(width: timerWidth, height: timerHeight)
            .padding(.top, topPadding)
            Spacer()
            HStack(spacing: buttonsSpacing){
                Spacer()
                Button(action :{viewModel.startTimer()}){
                    Text("Start")
                        .customButtonDesign()
                }
                /*
                Button(action :{viewModel.pauseTimer()}){
                    Text("Pause")
                        .customButtonDesign()
                }*/
                Button(action :{viewModel.stopTimer()}){
                    Text("Stop")
                        .customButtonDesign()
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
        .onAppear() {
            // no need for UI updates at startup
            viewModel.stopTimer()
            
        }
        .onReceive(viewModel.timer) { _ in
            // If timer has been completed then reset
            if viewModel.hasCountdownCompleted {
                viewModel.stopTimerAutomatically() // turn off timer
                viewModel.setDefaults()
            } else {
                viewModel.updateTimer()
            }
        }
    }
}

