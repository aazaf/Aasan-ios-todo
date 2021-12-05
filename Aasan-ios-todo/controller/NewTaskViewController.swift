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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
        observeKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         taskTextField.becomeFirstResponder()
     }
    
    private func setupViews(){
         backgroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
         containerViewBottomConstraint.constant = -containerView.frame.height
     }
    
    private func setupGesture(){
         let tapGesture = UITapGestureRecognizer(target: self, action:
             #selector(dismissViewController))
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
    
    @objc private func dismissViewController(){
         dismiss(animated: true, completion: nil)
     }
}

