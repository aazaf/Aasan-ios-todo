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
    
    weak var delegate: CalendarViewDelegate?
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        return calendar
    }()
    
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Select deadline"
        lable.font = UIFont.init(name: "AvenirNext-semiBold", size: 14)
        lable.textAlignment = .center
        return lable
    }()
    
     private lazy var removeButton: UIButton = {
        let butoon = UIButton(type: .system)
        butoon.setTitle("remove", for: .normal)
        butoon.setTitleColor(.white, for: .normal)
        butoon.backgroundColor = .systemRed
        butoon.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
       return butoon
    }()
    
    private lazy var stackVeiw: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLable, calendar, removeButton ])
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
            stackVeiw.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            calendar.heightAnchor.constraint(equalToConstant: 240),
            titleLable.heightAnchor.constraint(equalToConstant: 24),
            removeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func removeButtonTapped(_ sender: UIButton ){
        
        if let selectedDate = calendar.selectedDate{
            calendar.deselect(selectedDate)
            delegate?.calendarViewDidTapRemoveButton()
        }
    }
}

extension CalendarView : FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.calendarViewDidSelectDate(date: date)
    }
}
