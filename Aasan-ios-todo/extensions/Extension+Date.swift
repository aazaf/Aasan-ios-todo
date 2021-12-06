//
//  Extension+Date.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/6/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter.string(from: self)
    }
}
