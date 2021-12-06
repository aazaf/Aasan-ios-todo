//
//  DoneTaskTableViewCell.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit

class DoneTaskTableViewCell: UITableViewCell {
    
    var actionButtonDidTap : (() -> Void)?
    
    @IBOutlet weak var titleLable: UILabel!
    
    func configure(with task: Task){
        titleLable.text = task.title
    }
    
    @IBAction func actionButtonTapped(_ sender : UIButton){
        actionButtonDidTap?()
    }
}
