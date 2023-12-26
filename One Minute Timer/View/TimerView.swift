//
//  ContentView.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 23/12/2023.
//

import SwiftUI

struct TimerView: View {
    //MARK: - Properties
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: TimerViewModel
    @State private var isTimerRunning = false
    
    /// Color variation for the progress of the timer
    var progressColor: Color {
        let progress = viewModel.timeRemaining / 60 // Normalise the progress between 0 and 1
        return Color(hue: 0.3 * progress, saturation: 1, brightness: 0.8)
    }
    
    /// Formats timer time for display
    var formattedTime: String {
        let minutes = Int(viewModel.timeRemaining) / 60
        let seconds = Int(viewModel.timeRemaining) % 60
        let milliseconds = Int(viewModel.timeRemaining * 100) % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Text(formattedTime)
                        .font(.largeTitle)
                        .padding()
                        .onReceive(viewModel.$timeRemaining) { newTimeRemaining in
                            // This closure is called whenever timeRemaining changes
                            // Update any view-related logic here if needed
                            // For example, assign newTimeRemaining to a local state variable
                        }
                }
                //MARK: - ProgressView
                Circle()
                .stroke(lineWidth: K.progressBarWidth.value)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Circle()
                    .trim(from: 0, to: CGFloat(viewModel.timeRemaining / 60))
                    .stroke(style: StrokeStyle(lineWidth: K.progressBarWidth.value, lineCap: .round, lineJoin: .round))
                    .foregroundColor(progressColor)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
            }
            .frame(width: K.progressViewSize.value, height: K.progressViewSize.value)
            
            Spacer()
            //MARK: - Buttons
            HStack {
                Button(action: {
                    if isTimerRunning {
                        viewModel.pauseTimer()
                    } else {
                        viewModel.startTimer()
                    }
                    isTimerRunning.toggle()
                }) {
                    Text(isTimerRunning ? "Pause" : "Start")
                        .padding(10)
                        .foregroundColor(.primary)
                }
                .buttonStyle(CircularButtonStyle())
                
                Spacer()
                
                Button(action: {
                    viewModel.stopTimer()
                    isTimerRunning = false
                }) {
                    Text("Stop")
                        .padding(10)
                        .foregroundColor(.primary)
                }
                .buttonStyle(CircularButtonStyle())
                
            }
            .padding()
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: TimerViewModel())
    }
}
