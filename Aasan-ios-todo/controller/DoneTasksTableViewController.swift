//
//  DoneTasksTableViewController.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit

class DoneTasksTableViewController: UITableViewController {
    
    private var tasks: [Task] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    private let databaseManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskslistener()
    }
    
    private func addTaskslistener(){
        databaseManager.addTasksListener(forDoneTasks: true) { [weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DoneTasksTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for:
            indexPath) as! DoneTaskTableViewCell
        let task = tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
}
