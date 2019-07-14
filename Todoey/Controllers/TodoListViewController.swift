





import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory:Category? {
         didSet{
            loadItems()
        }
    }
 
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

   
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
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
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
          let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    
func saveItems() {
        

            do {
            try context.save()
            
        } catch  {
            
            print("Error saving context\(error)")
      
        }
        //defaults.set(self.itemArray ,forKey:"TodoListArray")
        self.tableView.reloadData()
    
        }
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil){
        //
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@" ,  selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , additionalPredicate ])
        } else {
            
            request.predicate = categoryPredicate
        }

        do{
            
           itemArray =  try context.fetch(request)
        } catch {
            print("Error fetching Data from Context\(error)")
            
        }
        tableView.reloadData()
    }
}
//MARK:- SEARCH BAR METHODS

extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request :NSFetchRequest<Item> = Item.fetchRequest()
        
      let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
     
}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
            }
            
        }
    }
    
    

}



