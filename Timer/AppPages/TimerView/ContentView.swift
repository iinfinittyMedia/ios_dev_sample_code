//
//  ContentView.swift
//  Timer
//
//  Created by Tariq Mahmood   on 25/12/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TimerViewModel
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Text("Timer").font(.largeTitle)
            
            Spacer()
            
            CircularProgressView(progress: viewModel.progress)
                .padding().frame(width: 250, height: 250)
            
            HStack{
                // MARK: - Start and Pause Button
                CustomButton(title: viewModel.isStartTimer ? "Pause" : "Start",buttonCondition: viewModel.isStartTimer,action: {
                    viewModel.isStartTimer.toggle()
                })
                
                // MARK: - Stop Button
                CustomButton(title: "Stop" ,action: {
                    viewModel.resetView()
                }).padding()
            }
            
            Spacer()
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { (_) in
            viewModel.onReceive()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (_, _) in
            }
            UNUserNotificationCenter.current().delegate = viewModel
        }
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel())
}


