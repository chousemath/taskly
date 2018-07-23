//
//  TaskUtility.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 22/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import Foundation

class TaskUtility {
    private static let key = "tasks"
    // archive the data
    private static func archive(_ tasks: [[Task]]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: tasks) as NSData
    }
    // fetch the data
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as? [[Task]]
    }
    
    // save the data
    static func save(_ tasks: [[Task]]) {
        let archivedData = archive(tasks)
        UserDefaults.standard.set(archivedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
