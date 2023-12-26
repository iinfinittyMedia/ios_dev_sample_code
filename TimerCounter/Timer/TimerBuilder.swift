//
//  TimerBuilder.swift
//  TimerCounter
//
//  Created by MDQ on 23/12/2023.
//

import SwiftUI

class TimerBuilder { // This is the builder class, we put all the dependency here due to SOLID priniciple
    func build() -> some View {
        let viewModel = TimerViewModelImplement()
        let timerView = TimerView(viewModel: viewModel) // Dependency Injection here with Dependency Inversion Principle
        return timerView
    }
}
