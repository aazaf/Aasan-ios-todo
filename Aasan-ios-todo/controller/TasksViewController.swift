//
//  TasksViewController.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, Animatable {

    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksContainerView: UIView!
    @IBOutlet weak var doneTasksContainerView: UIView!
    
    private let databaseManager = DatabaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmenetedControl()
        
    }
    
    private func setupSegmenetedControl(){
        menuSegmentedControl.removeAllSegments()
        MenuSection.allCases.enumerated().forEach { (index, section) in
            menuSegmentedControl.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }
        menuSegmentedControl.selectedSegmentIndex = 0
        showContainerView(for: .ongoing)
    }
    
    
    @IBAction func segmentedControlChanged(_ sender:
          UISegmentedControl){
          
          switch sender.selectedSegmentIndex {
          case 0:
               showContainerView(for: .ongoing)
          case 1:
               showContainerView(for: .done)
          default:break
        }
      }
    
    
    private func showContainerView(for section: MenuSection){
        switch section {
        case .ongoing:
            ongoingTasksContainerView.isHidden = false
            doneTasksContainerView.isHidden = true
        case .done:
            ongoingTasksContainerView.isHidden = true
            doneTasksContainerView.isHidden = false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showNewTask",
            let destination = segue.destination as? NewTaskViewController {
            destination.delegate = self
        } else if segue.identifier == "showOngoingTasks" {
            let destination = segue.destination as?
            OngoingTasksTableViewController
            destination?.delegate = self
        }
    }
    
    private func deleteTask(id: String){
        databaseManager.deleteTask(id: id) { [weak self] (result) in
            switch result {
            case .success:
                self?.showToast(state: .success, message: "task deleted", duration: 2.0)
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func addTasksButtonTapped(_ sender: UIButton){
         performSegue(withIdentifier: "showNewTask", sender: nil)
    }
}

extension TasksViewController: OngoingTasksTVCDelegate{
    
     func showOptions(for task: Task){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){[unowned self] _ in
            guard let id = task.id else { return }
            self.deleteTask(id: id)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TasksViewController: TasksVCDelegate {
    func didAddTask(_ task: Task) {
        
        presentedViewController?.dismiss(animated: true, completion : { [unowned self] in
            self.databaseManager.addTask(task) { (result) in
                switch result{
                case .success:
                    print("done")
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        })
    }
}

