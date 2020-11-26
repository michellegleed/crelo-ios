//
//  Extensions.swift
//  crelo
//
//  Created by michelle gleed on 27/11/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import SwiftUI


extension View {
    
    static func dateToIso (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.string(from: date)
    }
}

