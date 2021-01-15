//
//  TableViewController.swift
//  ToDoList
//
//  Created by Danil Zalizchuk on 14.01.2021.
//

import UIKit

class TableViewController: UITableViewController {
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавление новой задачи", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Новая задача..."
        }
        let alertAction1 = UIAlertAction(title: "Отмена", style: .destructive) { (alert) in
        }
        let alertAction2 = UIAlertAction(title: "Добавить", style: .default) { (alert) in
            let text = alertController.textFields![0].text!
            if text != "" {
                addItem(newItem: text)
            } else {
                addItem(newItem: "Новая задача")
            }
            
            self.tableView.reloadData()
            UIApplication.shared.applicationIconBadgeNumber = countUncomplitedTasks()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item["Name"] as? String
        
        if (item["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "check")
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
        }

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            UIApplication.shared.applicationIconBadgeNumber = countUncomplitedTasks()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.isEditing {
            let alertController = UIAlertController(title: "Изменение задачи", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Задача..."
                textField.text = getItemName(index: indexPath.row)
            }
            let actionButton1 = UIAlertAction(title: "Отмена", style: .destructive) { (action) in
            }
            let actionButton2 = UIAlertAction(title: "Изменить", style: .default) { (action) in
                let itemName = alertController.textFields![0].text == "" ? "Задача" : alertController.textFields![0].text
                changeItemName(index: indexPath.row, newName: itemName!)
                tableView.reloadData()
            }
            alertController.addAction(actionButton1)
            alertController.addAction(actionButton2)
            present(alertController, animated: true, completion: nil)
        } else {
            if changeState(index: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check")
            } else {
                tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
            }
            UIApplication.shared.applicationIconBadgeNumber = countUncomplitedTasks()
        }
        
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        rearrangeItem(from: fromIndexPath.row, to: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
