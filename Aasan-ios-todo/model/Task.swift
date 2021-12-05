//
//  Task.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    
    @DocumentID var id : String?
    @ServerTimestamp var createAt : Date?
    let title : String
    var isDone: Bool = false
    var doneAt: Date?
    
    
}
