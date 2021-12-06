//
//  NewTaskViewController.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit
import Combine

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deadLineLable: UILabel!
    

    private var subscribers = Set<AnyCancellable>()
    
    @Published private var taskString: String?
    @Published private var deadline: Date?
    
    weak var delegate : TasksVCDelegate?
    
    private lazy var calanderView: CalendarView = {
       let view = CalendarView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        observeForm()
        setupGesture()
        observeKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         taskTextField.becomeFirstResponder()
     }
    
    private func observeForm(){
        NotificationCenter.default.publisher(for:
            UITextField.textDidChangeNotification).map({
                ($0.object as? UITextField)?.text
            }).sink {[unowned self] (text) in
                self.taskString = text
            }.store(in: &subscribers)
        
        $taskString.sink {[unowned self] (text) in
            self.saveButton.isEnabled = text?.isEmpty == false
        }.store(in: &subscribers)
        
        $deadline.sink { (date) in
            self.deadLineLable.text = date?.toString() ?? ""
        }.store(in: &subscribers)
    }
    
    private func setupViews(){
         backgroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
         containerViewBottomConstraint.constant = -containerView.frame.height
     }
    
    private func setupGesture(){
         let tapGesture = UITapGestureRecognizer(target: self, action:
             #selector(dismissViewController))
        tapGesture.delegate = self
         view.addGestureRecognizer(tapGesture)
     }
    
    private func observeKeyboard(){
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification : Notification){
         let keyboardHeight = getKeyboardHeight(notification: notification)
         containerViewBottomConstraint.constant = keyboardHeight - (200 + 8)
     }
    
    @objc func keyboardWillHide(_ notification : Notification){
           containerViewBottomConstraint.constant = -containerView.frame.height
       }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
          guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
              NSValue)?.cgRectValue.height else {return 0}
          return keyboardHeight
      }
    
    private func showCalander() {
        view.addSubview(calanderView)
        NSLayoutConstraint.activate([
            calanderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calanderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calanderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func dismissCalendarView(completion: () -> Void){
        calanderView.removeFromSuperview()
        completion()
        
    }
    
    @objc private func dismissViewController(){
         dismiss(animated: true, completion: nil)
     }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        taskTextField.resignFirstResponder()
        showCalander()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskString = self.taskString else { return}
        let task = Task.init(title: taskString)
        delegate?.didAddTask(task)
    }
    
}

extension NewTaskViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch:
        UITouch) -> Bool {
        if calanderView.isDescendant(of: view){
            if touch.view?.isDescendant(of: calanderView) == false{
                dismissCalendarView { [unowned self] in
                    self.taskTextField.becomeFirstResponder()
                }
            }
            return false
        }
        return true
    }
}

extension NewTaskViewController : CalendarViewDelegate{
    func calendarViewDidSelectDate(date: Date) {
        dismissCalendarView { [unowned self] in
            self.taskTextField.becomeFirstResponder()
            self.deadline = date
        }
    }
    
    func calendarViewDidTapRemoveButton() {
        
    }
    
    
}
