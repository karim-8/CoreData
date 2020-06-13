//
//  ViewController.swift
//  Todey
//
//  Created by Karem on 6/7/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var staticArr = [Item]()
    //declaring instance to inject data inside
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //printing file path
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
    }

    
    //MARK:- TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = staticArr[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //true = false & false = true
        staticArr[indexPath.row].done = !staticArr[indexPath.row].done
       
        //updating item then saving
        ///todo: create a alert dialogue to update with name instead of completed
       // updateItems(indexPath: indexPath)
       saveItems()
        //Hide shadow while selecting row
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK:- Adding New Items
    
    @IBAction func addNewItems(_ sender: Any) {
        var textField = UITextField()
        
        //adding alert view so user can add new items
        let alert = UIAlertController(title: "Adding New Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (UIAlertAction) in
           
            let newItem = Item(context: self.context)
            newItem.name = textField.text!
            newItem.done = false
            
            self.staticArr.append(newItem)
            self.saveItems()
            self.tableView.reloadData()
        }
        //creating textfield inside alert dialogue
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Items"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    //MARK:- Model Mainpulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch  {
            print("Error saving data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems () {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            staticArr =  try context.fetch(request)
        } catch  {
            print("error fetching data \(error)")
        }
        
    }
    
    //update items

    func updateItems(indexPath:IndexPath) {
    staticArr[indexPath.row].setValue("updated", forKey: "name")
    saveItems()
    tableView.reloadData()
    }
    
    
    func deleteItems(indexPath:IndexPath ) {
        context.delete(staticArr[indexPath.row])
        staticArr.remove(at: indexPath.row)
        saveItems()
    }
    
    //handle swipe to delete method
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.deleteItems(indexPath: indexPath)
            tableView.reloadData()
            //self.deleteDataFromDB(indexPath: indexPath)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.updateItems(indexPath: indexPath)
            
        }
        editAction.backgroundColor = .purple
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction,editAction
        ])
        
        return swipeActions
    }
    
    
    /*********************************************************************************/
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

