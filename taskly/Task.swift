//
//  Task.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 21/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var description: String
    var isDone: Bool
    
    init(name: String, description: String, isDone: Bool = false) {
        self.name = name
        self.description = ""
        self.isDone = isDone
    }
}
