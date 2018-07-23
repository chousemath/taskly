//
//  Task.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 21/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {

    var name: String?
    var taskDescription: String?
    var isDone: Bool?
    
    let nameKey = "name"
    let taskDescriptionKey = "taskDescription"
    let isDoneKey = "isDone"
    
    init(name: String, taskDescription: String, isDone: Bool = false) {
        self.name = name
        self.taskDescription = ""
        self.isDone = isDone
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(taskDescription, forKey: taskDescriptionKey)
        aCoder.encode(isDone, forKey: isDoneKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
              let taskDescription = aDecoder.decodeObject(forKey: taskDescriptionKey) as? String,
              let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool
              else { return }
        
        self.name = name
        self.taskDescription = taskDescription
        self.isDone = isDone
    }
}
