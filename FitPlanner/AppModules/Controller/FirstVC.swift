//
//  ViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit
import FSCalendar

class FirstVC: UIViewController {
    
    // MARK: Properties
    let nextWorkoutLabel = FPLabel(title: "Your next workout", color: .primary, size: 18, weight: .medium)
    let nextWorkoutCard = NextWorkoutCard()
    let yourActivityLabel = FPLabel(title: "Your activity", color: .primary, size: 18, weight: .medium)
    weak var calendar: FSCalendar!
    
    var formatter = DateFormatter()

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FPBackground
        //Router.presentController(from: self, to: GetStartedVC(), animated: false)
        
        setupUI()
    }

    
    // MARK: UI Setup
    fileprivate func setupUI() {
        
        view.addSubview(nextWorkoutLabel)
        nextWorkoutLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40, paddingLeft: 20)
        
        view.addSubview(nextWorkoutCard)
        nextWorkoutCard.anchor(top: nextWorkoutLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(yourActivityLabel)
        yourActivityLabel.anchor(top: nextWorkoutCard.bottomAnchor, left: view.leftAnchor, paddingTop: 32, paddingLeft: 20)
        
        // calendar setup
        setupCalendar()
    }
    
    fileprivate func setupCalendar() {
        let calendarbackground = FPBackground(radius: 8)
        view.addSubview(calendarbackground)
        calendarbackground.anchor(top: yourActivityLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingRight: 20, height: 320)
        calendarbackground.addShadow(color: .black, opacity: 0.15, x: 0, y: 4, radius: 8)
        
        let calendar = FSCalendar(frame: CGRect(x: 20, y: 10, width: view.frame.size.width - 80, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.appearance.headerTitleColor = .FPBlue
        calendar.appearance.weekdayTextColor = .FPTextFieldPlaceholder
        calendar.appearance.todayColor = .FPBlue
        calendar.appearance.titleTodayColor = .white
        // calendar.pagingEnabled = false   ~ this makes the calendar NOT scrollable
        calendarbackground.addSubview(calendar)
        self.calendar = calendar
    }

}


// MARK: Celendar Delegates
extension FirstVC: FSCalendarDataSource, FSCalendarDelegate{
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Date Selected: \(formatter.string(from: date))")
    }
    
}

