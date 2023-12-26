//
//  CustomButtonModifier.swift
//  CountDownTimer
//
//  Created by MacBook on 24/12/2023.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    
    let cornerRadiusButton:CGFloat = 20.0
    let buttonWidth:CGFloat = 100.0
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .frame(width: buttonWidth)
            .background(Color.blue)
            .cornerRadius(cornerRadiusButton)
    }
}
