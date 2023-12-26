//
//  LaunchView.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 24/12/2023.
//

import SwiftUI

struct LaunchView: View {
    //MARK: - State Properties
    
    // State properties to control size and opacity changes
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    // Timer icon using SF Symbols
                    Image(systemName: "timer")
                        .font(.system(size: 250))
                        .foregroundColor(.primary)
                }
            }
            .scaleEffect(size) // Applying scale effect based on 'size'
            .opacity(opacity) // Applying opacity based on 'opacity'
            .onAppear {
                // Animation on view appearance
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 1.0 // Increase size to 1.0 with animation
                    self.opacity = 1.0 // Increase opacity to 1.0 with animation
                }
            }
        }
    }
}

//MARK: - Preview

#Preview {
    LaunchView() // Previewing the LaunchView
}
