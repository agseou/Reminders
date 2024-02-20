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
    
    func createItem(_ item: ReminderModel) {
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
    
    func fetchItem() -> Results<ReminderModel> {
        return realm.objects(ReminderModel.self)
    }
    
}
