//
//  Users.swift
//  iBadoo
//
//  Created by Sergiu Suru on 1/31/18.
//  Copyright © 2018 Sergiu Suru. All rights reserved.
//


import Foundation

class UserModel {
    
    let from: String
    let subject: String
    let body: String
    let date: Date
//    var unread = false
    var addFriend = false
    var blockFriend = false
    
    init(from: String, subject: String, body: String, date: Date) {
        self.from = from
        self.subject = subject
        self.body = body
        self.date = date
    }
    
    var relativeDateString: String {
        if Calendar.current.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: date)
        }
    }
    
}

extension Calendar {
    static func now(addingDays days: Int) -> Date {
        return Date().addingTimeInterval(Double(days) * 60 * 60 * 24)
    }
}


