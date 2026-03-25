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

        var relativeTime: String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        }
        
        // ✅ Short version — "16h ago", "1d ago", "2w ago"
        var relativeTimeShort: String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .abbreviated
            return formatter.localizedString(for: self, relativeTo: Date())
        }
    }

