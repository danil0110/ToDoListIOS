//
//  Model.swift
//  ToDoList
//
//  Created by Danil Zalizchuk on 14.01.2021.
//

import Foundation

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.setValue(newValue, forKey: "ToDoItemsKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let loadedData = UserDefaults.standard.array(forKey: "ToDoItemsKey") as? [[String : Any]] {
            return loadedData
        } else {
            return []
        }
    }
}

func addItem(newItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name": newItem, "isCompleted": isCompleted])
}

func removeItem(index: Int) {
    toDoItems.remove(at: index)
}

func getItemName(index: Int) -> String {
    return toDoItems[index]["Name"] as! String
}

func changeItemName(index: Int, newName: String) {
    toDoItems[index]["Name"] = newName as Any
}

func countUncomplitedTasks() -> Int {
    var count: Int = 0
    for item in toDoItems {
        count += (item["isCompleted"] as! Bool) == true ? 0 : 1
    }
    return count
}

func rearrangeItem(from: Int, to: Int) {
    let item = toDoItems.remove(at: from)
    toDoItems.insert(item, at: to)
}

func changeState(index: Int) -> Bool {
    toDoItems[index]["isCompleted"] = !(toDoItems[index]["isCompleted"] as! Bool)
    return toDoItems[index]["isCompleted"] as! Bool
}
