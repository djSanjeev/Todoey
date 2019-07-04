//
//  ViewController.swift
//  Todoey
//
//  Created by Sanjeev Vyas on 02/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")//["Find Mike" , "Buy Eggos" , "Destroy Demogorgon" ,"a" , "a" , "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o" , "p"]
// let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        print(dataFilePath)
        
//
    loadItems()
    }
//MARK - Tableview Data Source Methods
    
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
//MARK - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
        
        
        saveItems()
        

        tableView.deselectRow(at: indexPath, animated: true)
 
        
        //MARK - Pragma mark for GIT
        
        //MARK - Pragma mark2 for GIT
    }
    
    //MARK - Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "!!!!!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default)
        { (action) in
            //what will happen once the user clicks the add item button on our UIalert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
            
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create New Item"
            textField = alertTextField
           
        }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    
    //MARK - Model Manupulatio Methods
    
    func saveItems(){
        
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch  {
            
            print("Error encoding item into array, \(error)")
            
            
        }
        //defaults.set(self.itemArray ,forKey:"TodoListArray")
        tableView.reloadData()
        //print("Success")
        }
    
    func loadItems(){
        
        if let data = try?  Data(contentsOf: dataFilePath!) {
            
             let decoder = PropertyListDecoder()
            do {
                
                 itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
                print("Error decoding item array,\(error)")
        }
        
        
    }
        
    }




}
