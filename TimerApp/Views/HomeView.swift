//
//  HomeView.swift
//  TimerApp
//
//  Created by Suleman Ali on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: TimerViewModel
    @Environment(\.scenePhase) var scene
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
            VStack {
                Text("Timer App").font(.largeTitle)
                Spacer()
                TimerView(progress: viewModel.progress,totalProgress: viewModel.totalTime)
                    .padding()
                    .frame(width: 300, height: 300)
                HStack{
                    // MARK: - Start and Pause Button
                    Button(action: {
                        viewModel.isTimerStarted.toggle()
                        if viewModel.isTimerStarted  && viewModel.selectedTime == viewModel.totalTime {
                            viewModel.startFromZero()
                        }
                    }) {
                        Text(viewModel.isTimerStarted ? "Pause" : "Start")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .foregroundColor(viewModel.isTimerStarted ?  .red : .white )
                            .font(.system(size: 18).bold())
                            .background(
                                ZStack {
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .fill(viewModel.isTimerStarted ?  .clear : .red )
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .stroke(.red, lineWidth: 2)
                                }
                            )
                    }
                        // MARK: - Start and Stop Button
                    Button(action: {
                        viewModel.resetView()
                    }) {
                        Text("Stop").padding(.horizontal, 20)
                            .padding(.vertical, 6)
                            .foregroundColor(.white )
                            .font(.system(size: 18).bold())
                            .background(
                                ZStack {
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .fill(.red )
                                    RoundedRectangle(
                                        cornerRadius: 14,
                                        style: .continuous
                                    )
                                    .stroke(.red, lineWidth: 2)
                                }
                            )
                    }
                    .padding()
                }
                Spacer()
            }.onReceive(viewModel.$isCompleted){
                if $0 && scene == .background {
                    self.addNotifications()
                }
            }
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (_, _) in
                }
                UNUserNotificationCenter.current().delegate = viewModel
            }
    }

    private  func addNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Notification from Timer App"
        content.body = "Timer is finished!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.001, repeats: false)
        let request = UNNotificationRequest(identifier: "TIMER", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: TimerViewModel(time: 10))
}
