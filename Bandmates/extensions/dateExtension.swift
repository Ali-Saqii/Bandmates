//
//  dateExtension.swift
//  Bandmates
//
//  Created by Mac mini on 16/03/2026.
//

import Foundation
import Foundation

extension Date {
    
    static let billingDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var billingFormatted: String {
        return Date.billingDateFormatter.string(from: self)
    }
}
