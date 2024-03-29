//
//  List+Enum.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/22.
//

import UIKit
import RealmSwift

let repository = ReminderRepository()

enum SortList: CaseIterable {
    
    case Expected
    case Today
    case All
    case Flag
    case Complete
    case Assignment
    
    var title: String {
        switch self {
        case .Expected:
            "예정"
        case .Today:
            "오늘"
        case .All:
            "전체"
        case .Flag:
            "깃발 표시"
        case .Complete:
            "완료됨"
        case .Assignment:
            "할당"
        }
    }
    
    var color: UIColor {
        switch self {
        case .Expected:
                .systemRed
        case .Today:
                .systemBlue
        case .All:
                .label
        case .Flag:
                .systemOrange
        case .Complete:
                .systemGray
        case .Assignment:
                .systemGreen
        }
    }
    
    var icon: UIImage {
        switch self {
        case .Expected:
            UIImage(systemName: "calendar")!
        case .Today:
            UIImage(systemName: "calendar")!
        case .All:
            UIImage(systemName: "tray.fill")!
        case .Flag:
            UIImage(systemName: "flag.fill")!
        case .Complete:
            UIImage(systemName: "checkmark")!
        case .Assignment:
            UIImage(systemName: "person.fill")!
        }
    }
    
    var num: Int {
        switch self {
        case .Expected:
            repository.fetchItem(ofType: ReminderModel.self).filter { item in
                guard let item = item.date else { return false }
                return Date() < item
            }.count
        case .Today:
            repository.fetchItem(ofType: ReminderModel.self).filter { item in
                guard let item = item.date else { return false }
                return Calendar.current.isDateInToday(item)
            }.count
        case .All:
            repository.fetchItem(ofType: ReminderModel.self).count
        case .Flag:
            repository.fetchItem(ofType: ReminderModel.self).filter({ item in
                item.flag
            }).count
        case .Complete:
            repository.fetchItem(ofType: ReminderModel.self).filter({ item in
                item.compelete
            }).count
        case .Assignment:
            repository.fetchItem(ofType: ReminderModel.self).count
        }
    }
}
