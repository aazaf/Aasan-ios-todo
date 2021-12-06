//
//  CalendarViewDelegate.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/6/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import Foundation

protocol CalendarViewDelegate: class {
    
    func calendarViewDidSelectDate(date: Date)
    func calendarViewDidTapRemoveButton()
}
