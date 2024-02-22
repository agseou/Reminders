//
//  ReminderModel.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import Foundation
import RealmSwift

class ReminderModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String // 제목
    @Persisted var memo: String? // 한 줄 메모(옵션)
    @Persisted var date: Date? // 마감날짜
    @Persisted var tags: List<String?> // 태그
    @Persisted var priority: Int? // 우선순위
    @Persisted var compelete: Bool // 완료여부
    @Persisted var flag: Bool // 깃발
    
    convenience init(
        title: String,
        memo: String? = nil,
        finalDate: Date? = nil,
        tags: List<String?> = List<String?>(),
        priority: Int? = nil,
        compelete: Bool,
        flag: Bool
    ) {
        self.init()
        self.title = title
        self.memo = memo
        self.date = date
        self.tags = tags
        self.priority = priority
        self.compelete = false // 생성시에 기본은 false
        self.flag = false // 생성시에 기본은 false
    }
}
