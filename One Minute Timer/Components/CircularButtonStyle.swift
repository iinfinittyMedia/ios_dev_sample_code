//
//  CircularButtonStyle.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 24/12/2023.
//

import SwiftUI

// Button style to create circular buttons with specific visual characteristics
struct CircularButtonStyle: ButtonStyle {
    // Applies the style to the button
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.clear) // Sets the button label's text color to clear
            .padding(10) // Adds padding around the button
            .background(
                Circle() // Creates a circular background
                    .stroke(Color.gray, lineWidth: 2) // Sets the circle's stroke color and width
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0) // Scales the button when pressed
    }
}
