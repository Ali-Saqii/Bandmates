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
    
    func toRelativeString() -> String {
        let calendar = Calendar.current
        let now = Date()

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let timeString = timeFormatter.string(from: self)

        if calendar.isDateInToday(self) {
            return "Today at \(timeString)"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday at \(timeString)"
        }

        let startOfNow = calendar.startOfDay(for: now)
        let startOfSelf = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfNow)

        if let days = components.day, days < 7 {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return "Last \(dayFormatter.string(from: self)) at \(timeString)"
        }

        let fullFormatter = DateFormatter()
        fullFormatter.dateFormat = "MMM d 'at' h:mm a"
        return fullFormatter.string(from: self)
    }
    }

