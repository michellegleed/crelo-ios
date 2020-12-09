//
//  Extensions.swift
//  crelo
//
//  Created by michelle gleed on 27/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI
import Foundation

extension View {
    
    static func dateToIso (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.string(from: date)
    }
    
    static func isoToDate (date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let theDate = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        return dateFormatter.string(from: theDate)
    }
    
    static func getDaysRemaining (date: String) -> String {
        let fmt = ISO8601DateFormatter()

        let currentDate = Date()
        let futureDate = fmt.date(from: date)!

        let diffs = Calendar.current.dateComponents([.day, .hour], from: currentDate, to: futureDate)
        
        if diffs.day != nil {
            return "\(diffs.day!) days remaining"
            }
            else {
                return "\(diffs.hour!) hours remaining"
        }
    }
}

