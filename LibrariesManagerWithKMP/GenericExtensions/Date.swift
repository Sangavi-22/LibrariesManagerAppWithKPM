//
//  Date.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import Foundation
extension Date {
    init?(from string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }

}

