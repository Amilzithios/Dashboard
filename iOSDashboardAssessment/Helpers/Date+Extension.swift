//
//  Date+Extension.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//
import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        
        // Get the day with the appropriate suffix
        let daySuffix: (Int) -> String = { day in
            switch day {
            case 1, 21, 31: return "st"
            case 2, 22: return "nd"
            case 3, 23: return "rd"
            default: return "th"
            }
        }
        
        // Get the day component from the date
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        
        // Format the date
        let formattedDate = formatter.string(from: self) + daySuffix(day)
        
        // Add the year component
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: self)
        
        return "\(formattedDate), \(year)"
    }
}
