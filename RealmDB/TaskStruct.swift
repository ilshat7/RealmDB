//
//  TaskStruct.swift
//  RealmDB
//
//  Created by Ильшат Мухамедьянов on 02.07.2021.
//

import Foundation
import RealmSwift

class TaskStruct: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var index = 0
    @objc dynamic var task = ""
    
}
