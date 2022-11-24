//
//  Date+Extension.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func getStringDate(toFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = toFormat
        return formatter.string(from: self)
    }
}
