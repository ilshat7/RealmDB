//
//  TasksTableViewController.swift
//  RealmDB
//
//  Created by Ильшат Мухамедьянов on 02.07.2021.
//

import UIKit


class TasksTableViewController: UITableViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksArray = realm.objects(TaskStruct.self)
    }

    @IBAction func addTaskButton(_ sender: Any) {
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let text = alert.textFields?.first?.text else { return }
            let task = TaskStruct()
            task.task = text
            try! realm.write {
                realm.add(task)
            }
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addTextField()
        alert.textFields?[0].placeholder = "Введите задачу"
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasksArray[indexPath.row].task
        return cell
    }
    //MARK: - Delete item
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {(_,_,complition) in
            try! realm.write {
                realm.delete(tasksArray[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = .red
        let deleteActionConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return deleteActionConfig
    }
    //MARK: - Move item
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tempArray = [String]()
        for task in tasksArray {
            tempArray.append(task.task)
        }
        try! realm.write({
            realm.deleteAll()
        })
        let tempItem = tempArray[sourceIndexPath.row]
        tempArray.remove(at: sourceIndexPath.row)
        tempArray.insert(tempItem, at: destinationIndexPath.row)
        for item in tempArray {
            let task = TaskStruct()
            task.task = item
            try! realm.write {
                realm.add(task)
            }
        }
        
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = tableView.isEditing ? "Закончить" : "Изменить"
    }
}
