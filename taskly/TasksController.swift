//
//  TasksController.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 21/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import UIKit

class TasksController: UITableViewController {
    var taskStore = TaskStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toDos = [
            Task(name: "Wake up"),
            Task(name: "Go to work"),
            Task(name: "Code some stuff")
        ]
        let dones = [
            Task(name: "Save the world"),
            Task(name: "Solve world hunger"),
            Task(name: "Deflect meteorite")
        ]
        taskStore.tasks = [toDos, dones]
    }
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        // initialize the alert controller
        let alertCtrl = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        // define actions (the cancel and add buttons)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        // configure the text field
        alertCtrl.addTextField { textField in
            textField.placeholder = "Enter task name"
        }
        // actually attach the actions to the alert controller
        alertCtrl.addAction(addAction)
        alertCtrl.addAction(cancelAction)
        // present the alert controller
        present(alertCtrl, animated: true)
    }
    
}

// MARK: - DataSource
extension TasksController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "To Do"
        case 1: return "Done"
        default: return "Lol I don't know"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // UILabel that serves as a title
        cell.textLabel?.text = taskStore.tasks[indexPath.section][indexPath.row].name
        return cell
    }
}


