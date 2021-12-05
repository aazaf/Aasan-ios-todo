//
//  OngoingTaskTableViewCell.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit

class OngoingTaskTableViewCell: UITableViewCell  {
    
    var actionButtonDidTap : (() -> Void)?
    
    @IBOutlet weak var titleLable : UILabel!
    @IBOutlet weak var deadlineLabel : UILabel!
    
    func configure(with taks: Task) {
         titleLable.text = taks.title
     }
    
    @IBAction func actionButtonTapped(_ sender : UIButton){
        actionButtonDidTap?()
    }
}
