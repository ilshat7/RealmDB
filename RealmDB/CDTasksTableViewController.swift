//
//  TaskTableViewController.swift
//  CoreDataFirst
//
//  Created by Ильшат Мухамедьянов on 04.07.2021.
//

import UIKit


class CDTasksTableViewController: UITableViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @IBAction func addTaskButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let text = alert.textFields?.first?.text else { return }
            save(task: text)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].task
        return cell
    }
    
    //MARK: - Delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            managedContext.delete(task)
            appDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    //MARK: - Move item
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempItem = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(tempItem, at: destinationIndexPath.row)
        
        for (index,task) in tasks.enumerated(){
             task.index = Int64(index)
        }
        appDelegate.saveContext()
        tableView.reloadData()
    }
    
    @IBAction func editBtn(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
    
}
