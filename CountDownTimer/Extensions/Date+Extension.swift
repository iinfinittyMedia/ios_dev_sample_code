//
//  Date+Extension.swift
//  CountDownTimer
//
//  Created by MacBook on 24/12/2023.
//

import Foundation

extension Date{
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter.string(from: self)
    }
    static var dateByAddingMinute:Date{
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .minute, value: 1, to: Date())
        return endDate ?? Date()
    }
    static func componentsFromDate(endDate:Date) -> DateComponents{
        let calendar = Calendar(identifier: .gregorian)
        let timeValue = calendar.dateComponents([.day,.hour,.minute, .second], from: Date(), to: endDate)
        let components = DateComponents(day: timeValue.day, hour: timeValue.hour, minute: timeValue.minute, second: timeValue.second)
        return components
    }
    static func dateFromComponents(components:DateComponents) -> Date?{
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)
    }
    static func dateByAdding(seconds:Int) -> Date{
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .second, value: seconds, to: Date())
        return endDate ?? Date()
    }
}
