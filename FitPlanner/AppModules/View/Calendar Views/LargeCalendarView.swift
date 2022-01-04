//
//  LargeCalendarView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit
import FSCalendar

class LargeCalendarView: UIView {
    
    // MARK: Properties
    weak var calendar: FSCalendar!
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    
    // MARK: Setup UI
    fileprivate func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        addShadow(color: .black, opacity: 0.15, x: 0, y: 4, radius: 8)
        setConstantHeight(height: 320)
        
        let calendar = FSCalendar()
        addSubview(calendar)
        calendar.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                        paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
        
        calendar.appearance.headerTitleColor = .FPBlue
        calendar.appearance.weekdayTextColor = .FPTextFieldPlaceholder
        calendar.appearance.todayColor = .FPBlue
        calendar.appearance.titleTodayColor = .white
        // calendar.pagingEnabled = false   ~ this makes the calendar NOT scrollable
        addSubview(calendar)
        self.calendar = calendar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
