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
    @Persisted var regDate: Date? // 등록날
    @Persisted var finalDate: Date? // 마감날짜
    @Persisted var tags: String? // 태그
    @Persisted var priority: Int? // 우선순위
    @Persisted var compelete: Bool // 완료여부
    @Persisted var flag: Bool // 깃발
    
    convenience init(
        title: String,
        memo: String? = nil,
        regDate: Date? = nil,
        finalDate: Date? = nil,
        tags: String? = nil,
        priority: Int? = nil,
        compelete: Bool,
        flag: Bool
    ) {
        self.init()
        self.title = title
        self.memo = memo
        self.regDate = regDate
        self.finalDate = finalDate
        self.tags = tags
        self.priority = priority
        self.compelete = compelete
        self.flag = flag
    }
}
