//
//  CalendarView.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/6/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarView: UIView {
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var stackVeiw: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [calendar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .white
        addSubview(stackVeiw)
        NSLayoutConstraint.activate([
            stackVeiw.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackVeiw.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackVeiw.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackVeiw.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 24),
            stackVeiw.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
}
