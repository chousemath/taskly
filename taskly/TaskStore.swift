//
//  TaskStore.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 21/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import Foundation

class TaskStore {
    var tasks = [[Task](), [Task]()]
    
    func add(_ task: Task, at index: Int, isDone: Bool = false) {
        let section = isDone ? 1 : 0
        tasks[section].insert(task, at: index)
    }
    
    func remove(at index: Int, isDone: Bool = false) -> Task {
        let section = isDone ? 1 : 0
        return tasks[section].remove(at: index)
    }
}
