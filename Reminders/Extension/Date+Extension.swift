//
//  Date+Extension.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import Foundation

extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self)
    }
}
