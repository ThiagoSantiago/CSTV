//
//  String+Extension.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation

extension String {
    func formatDateStringToStringFormat(toFormat: String) -> String {
        let utcFormatter = ISO8601DateFormatter()
        guard let date = utcFormatter.date(from: self) else { return self }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
    
    func getDateFromString() -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: self)
        return date
    }
}
