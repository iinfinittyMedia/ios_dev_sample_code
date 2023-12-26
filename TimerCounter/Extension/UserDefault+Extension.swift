//
//  UserDefault+Extension.swift
//  TimerCounter
//
//  Created by MDQ on 23/12/2023.
//

import Foundation
extension UserDefaults {

    private struct Keys {
        static let runningTime = "startTimeRunning"

    }

    static var runningTime: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.runningTime) as? Date
        }
        set{
            UserDefaults.standard.set(newValue, forKey: Keys.runningTime)
        }
    }
}
