//
//  ViewController.swift
//  DoMeToday
//
//  Created by Randolph Davis Hill on 1/4/19.
//  Copyright © 2019 Randolph Davis Hill. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Get Food"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Do it Again"
        itemArray.append(newItem2)
        
        
        // Do any additional setup after loading the view.
    if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
        itemArray = items
       }
        
    }
    //Mark - Tableview DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    //Mark - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("Row: \(indexPath.row) item:" + itemArray[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
       var textField = UITextField()
        
        let alert  = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
}

