//
//  TimerView.swift
//  TimerApp
//
//  Created by Suleman Ali on 25/12/2023.
//

import SwiftUI
struct TimerView: View {
    var progress: Double
    var totalProgress = 60.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .butt, lineJoin: .bevel))
                .foregroundColor(.black)
            Circle()
                .trim(from: progress/totalProgress, to: 1.0)
                .stroke( LinearGradient(
                    gradient: Gradient(colors: [Color.green, Color.red]),
                    startPoint: .top,
                    endPoint: .bottom
                ),style: StrokeStyle(lineWidth: 20.8, lineCap: .butt, lineJoin: .bevel))
                .foregroundColor(Color.green)

                .rotationEffect(.init(degrees:270))
                .animation(.easeInOut,value: progress)

            Text(String(format: "%.2f", progress)
                .replacingOccurrences(of: ".", with: ":"))
            .font(.largeTitle)
            .padding()
        }
    }
}

#Preview {
    TimerView(progress: 10.0)
        .padding()
}
