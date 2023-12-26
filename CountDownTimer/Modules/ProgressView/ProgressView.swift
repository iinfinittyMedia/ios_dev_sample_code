//
//  ProgressView.swift
//  CountDownTimer
//
//  Created by MacBook on 23/12/2023.
//

import SwiftUI

struct ProgressView: View {
    let progress: Double
    let lineWidth:CGFloat = 30
    let degreesToRotate:Double = -90
    let opacityOfStroke = 0.5
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(opacityOfStroke),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
            // Rotating view to start the progress from the top
                .rotationEffect(.degrees(degreesToRotate))
            // Adding animation so it can progress with animation
                .animation(.easeOut, value: progress)
        }
    }
}
