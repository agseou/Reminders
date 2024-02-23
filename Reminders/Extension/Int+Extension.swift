//
//  Int+Extension.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/23.
//

import Foundation

extension Int {
    var priorityDescription: String? {
        switch self {
        case 0:
            return "없음"
        case 1:
            return "높음"
        case 2:
            return "중간"
        case 3:
            return "낮음"
        default:
            return nil
        }
    }
}
