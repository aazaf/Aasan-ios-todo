//
//  OngoingTasksTableViewController.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit
import Loaf

class OngoingTasksTableViewController: UITableViewController, Animatable {
    
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
        databaseManager.addTasksListener(forDoneTasks: false) { [weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handleActionButton(for task: Task){
        guard let id = task.id else { return }
        databaseManager.UpdateTaskToDone(id: id) { [weak self] (result) in
            switch result {
            case .success:
                self?.showToast(state: .info, message: "move to done", duration: 2.0)
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
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
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButton(for: task)
        }
        cell.configure(with: task)
        return cell
    }
}
