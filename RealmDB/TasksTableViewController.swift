//
//  TasksTableViewController.swift
//  RealmDB
//
//  Created by Ильшат Мухамедьянов on 02.07.2021.
//

import UIKit
import RealmSwift

class TasksTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var tasksArray: Results<TaskStruct>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksArray = realm.objects(TaskStruct.self)
    }

    @IBAction func addTaskButton(_ sender: Any) {
        // Создание алёрт контроллера
        let alert = UIAlertController(title: "Новая задача", message: "Пожалуйста заполните поле", preferredStyle: .alert)
        
        // Создание текстового поля
        var alertTextField: UITextField!
        alert.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Новая задача"
        }
        
        // Создание кнопки для сохранения новых значений
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            
            // Проверяем не является ли текстовое поле пустым
            guard let text = alertTextField.text, alertTextField.text?.isEmpty == false else {return}
            
            // Добавляем в массив новую задачу из текстового поля
//            self.tasksArray.append((alert.textFields?.first?.text)!)
            
            let task = TaskStruct()
            task.task = text
            try! self.realm.write {
                self.realm.add(task)
            }
            // Обновляем таблицу
            self.tableView.reloadData()
        }
        
        // Создаем кнопку для отмены ввода новой задачи
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(saveAction) // Присваиваем алёрту кнопку для сохранения результата
        alert.addAction(cancelAction) // Присваиваем алерут кнопку для отмены ввода новой задачи
        
        present(alert, animated: true, completion: nil) // Вызываем алёрт контроллер
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {(_,_,complition) in
            try! self.realm.write {
                self.realm.delete(self.tasksArray[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = .red
        let deleteActionConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return deleteActionConfig
    }
    
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
            try! self.realm.write {
                self.realm.add(task)
            }
        }
        
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = tableView.isEditing ? "Закончить" : "Изменить"
    }
    
}
