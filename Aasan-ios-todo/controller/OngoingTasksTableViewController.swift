//
//  OngoingTasksTableViewController.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit

class OngoingTasksTableViewController: UITableViewController {
    
    private let databaseManager = DatabaseManager()
    
    private var tasks: [Task] = [] {
           didSet{
               tableView.reloadData()
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskslistener()
    }
    
    private func addTaskslistener(){
        databaseManager.addTasksListener { [weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension OngoingTasksTableViewController{
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "cellId", for: indexPath) as! OngoingTaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
}
