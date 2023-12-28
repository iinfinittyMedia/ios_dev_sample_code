//
//  CustomButton.swift
//  Timer
//
//  Created by Tariq Mahmood   on 26/12/2023.
//

import SwiftUI

struct CustomButton: View {
    var title:String = ""
    var buttonCondition:Bool = false
    var action:(()->Void)?
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(title)
                .padding(.horizontal, 20)
                .padding(.vertical, 6)
                .foregroundColor(.white)
                .font(.system(size: 18).bold())
                .background(buttonCondition ? .blue.opacity(0.5) : .blue)
                .cornerRadius(20)
        }
    }
}

#Preview {
    CustomButton()
}
