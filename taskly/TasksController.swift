//
//  TasksController.swift
//  taskly
//
//  Created by Joseph Sungpil Choi on 21/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import UIKit

class TasksController: UITableViewController {
    // I know this has not yet be initialized, but I guarantee that by the time
    // it is actually used, it will have been initialized
    var taskStore: TaskStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        // initialize the alert controller
        let alertCtrl = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        // define actions (the cancel and add buttons)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            // grab textfield text
            guard let name = alertCtrl.textFields?.first?.text else { return }
            var description = ""
            if alertCtrl.textFields?[1].text != nil {
                description = alertCtrl.textFields![1].text!
            }
            // create task
            let task = Task(name: name, description: description)
            // add task
            self.taskStore.add(task, at: 0)
            // reload data in TableView
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        // disable the addAction button by default (refer to handleTextChange)
        addAction.isEnabled = false
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        // configure the text field
        alertCtrl.addTextField { textField in
            textField.placeholder = "Enter task name"
            textField.addTarget(self, action: #selector(self.handleTextChange), for: .editingChanged)
        }
        alertCtrl.addTextField { textField in
            textField.placeholder = "Enter task description"
        }
        // actually attach the actions to the alert controller
        alertCtrl.addAction(addAction)
        alertCtrl.addAction(cancelAction)
        // present the alert controller
        present(alertCtrl, animated: true)
    }
    
    // whenever you add an action to a specific target, you must add the
    // @objc prefix to make this action available to both the swift and
    // objective-c runtimes
    @objc private func handleTextChange(_ sender: UITextField) {
        // grab the alert controller and the add action
        guard let alertCtrl = presentedViewController as? UIAlertController,
              let addAction = alertCtrl.actions.first,
              let text = sender.text
              else { return }
        
        // disable add button if text field is empty or blank
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}

// MARK: - DataSource
extension TasksController {
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

// MARK: - Delegate
extension TasksController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            // determine if task is done
            let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone
            // remove the task for the to do array
            self.taskStore.remove(at: indexPath.row, isDone: isDone)
            // reload table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // and then indicate that the action was successfully performed
            print("Action was completed!")
            completionHandler(true)
        }
        deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
}


