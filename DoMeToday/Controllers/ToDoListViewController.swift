//
//  ViewController.swift
//  DoMeToday
//
//  Created by Randolph Davis Hill on 1/4/19.
//  Copyright © 2019 Randolph Davis Hill. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    // var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    var itemArray = [Item]()
    //let defaults = UserDefaults.standard
    
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        print("----------------")
        //loadItems()
        
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
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
       var textField = UITextField()
        
        let alert  = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newItem = Item(context:self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
             self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }



func saveItems(){
    
    
    do {
       try context.save()
    } catch {
        print("Error Saving context \(error)")
    }
    
    tableView.reloadData()
    
}
/*    func loadItems(){
        if let data = try? Data(contentsOf:dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from:data)
            } catch {
                print("Error decodeing it")
                
            }
        }
    }
 */
} //End Class
