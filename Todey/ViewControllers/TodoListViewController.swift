//
//  ViewController.swift
//  Todey
//
//  Created by Karem on 6/7/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var staticArr = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.name = "ka"
        newItem.done = true
        staticArr.append(newItem)
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
        tableView.reloadData()
        //Hide shadow while selecting row
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK:- Adding New Items
    
    @IBAction func addNewItems(_ sender: Any) {
        var textField = UITextField()
        
        //adding alert view so user can add new items
        let alert = UIAlertController(title: "Adding New Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (UIAlertAction) in
            let newItem = Item()
            newItem.name = textField.text!
            
            self.staticArr.append(newItem)
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
    
    
}

