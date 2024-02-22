//
//  ReminderRepository.swift
//  Reminders
//
//  Created by 은서우 on 2024/02/19.
//

import Foundation
import RealmSwift

final class ReminderRepository {
    
    private let realm = try! Realm()
    
    // 생성
    func createItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm create")
            }
        } catch {
            print(error)
        }
        print(realm.configuration.fileURL!)
    }
    
    // 데이터 주기
    func fetchItem<T: Object>(ofType type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
}
