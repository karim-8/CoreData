//
//  ViewController.swift
//  Todey
//
//  Created by Karem on 6/7/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let staticArr = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //MARK:- TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = staticArr[indexPath.row]
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Hide shadow while selecting row
        tableView.deselectRow(at: indexPath, animated: true)
        //adding accessory type
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
    
    }
    
}

