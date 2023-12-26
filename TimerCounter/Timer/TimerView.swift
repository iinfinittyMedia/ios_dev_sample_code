//
//  TimerView.swift
//  TimerCounter
//
//  Created by MDQ on 23/12/2023.
//

import SwiftUI

struct TimerView<T : TimerViewModel>: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @ObservedObject var viewModel: T

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: CGFloat(1.0 - (viewModel.timeRemaining / 60.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .overlay(
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.gray)
                            .opacity((viewModel.timeRemaining < 60) ? (0.5 * ((1.0 - (viewModel.timeRemaining / 60.0)) <= 0 ? 0.5 : 1)) : 0.5)

                    )
                    .mask(
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.yellow]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear, value: viewModel.timeRemaining)

                VStack {
                    Text(viewModel.getTimeString())
                    Text("Minutes : Seconds : Milli Seconds")
                        .font(.system(size: 12))
                }.font(.title)
                    .padding()
            }.padding()

            HStack {
                Button(action: {
                    viewModel.isRunning.toggle()
                }) {
                    Text(viewModel.isRunning ? "Pause" : "Start")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    viewModel.isRunning = false
                    viewModel.timeRemaining = 60
                }) {
                    Text("Stop")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            Text("1 Minute timer with Notification")
                .multilineTextAlignment(.center)
        }
    }

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TimerViewModelImplement()
        TimerView(viewModel: viewModel)
    }
}
