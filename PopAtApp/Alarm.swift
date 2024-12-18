//
//  Alarm.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 16/12/24.
//

import Foundation

struct Alarm: Identifiable, Equatable {
    var id = UUID()
    var time: Date
    var label: String
    var isActive: Bool

    var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
    
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        lhs.id == rhs.id
    }
}
