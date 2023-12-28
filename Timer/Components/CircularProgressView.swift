//
//  CircularProgressView.swift
//  Timer
//
//  Created by Tariq Mahmood   on 26/12/2023.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    var totalProgress = 60.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .butt, lineJoin: .bevel))
                .foregroundColor(Color.blue.opacity(0.5))
            Circle()
                .trim(from: progress/totalProgress, to: 1.0)
                .stroke(style: StrokeStyle(lineWidth: 20.8, lineCap: .butt, lineJoin: .bevel))
                .foregroundColor(Color.blue)
                .rotationEffect(.init(degrees: -90))
                .animation(.easeInOut,value: progress)

            Text(String(format: "%.2f", progress)
                .replacingOccurrences(of: ".", with: ":"))
            .foregroundColor(Color.blue)
            .font(.largeTitle)
            .padding()
        }
    }
}



#Preview {
    ContentView(viewModel: TimerViewModel())
}
