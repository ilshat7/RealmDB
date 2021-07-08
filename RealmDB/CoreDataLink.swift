//
//  CoreDataLink.swift
//  RealmDB
//
//  Created by Ильшат Мухамедьянов on 08.07.2021.
//
import UIKit
import Foundation
import CoreData

var tasks = [TaskStructure]()

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
// MARK: - Save data
func save (task: String){
    let tasksEntity = TaskStructure(entity: TaskStructure.entity(), insertInto: managedContext)
    tasksEntity.task = task
    tasksEntity.index = Int64(tasks.endIndex)
    appDelegate.saveContext()
    tasks.append(tasksEntity)
}

// MARK: - Load data
func loadData() {
    let fetch = TaskStructure.fetchRequest() as NSFetchRequest<TaskStructure>
    let sort = NSSortDescriptor(key: "index", ascending: true)
    fetch.sortDescriptors = [sort]
    do {
        tasks = try managedContext.fetch(fetch)
    }catch {
        print("Error read")
    }
}
