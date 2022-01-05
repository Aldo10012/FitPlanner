//
//  ViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit
import FSCalendar

class HomeVC: UIViewController {
    
    // MARK: Properties
    let nextWorkoutLabel = FPLabel(title: "Your next workout", color: .primary, size: 20, weight: .medium)
    let nextWorkoutCard = NextWorkoutCard()
    let yourActivityLabel = FPLabel(title: "Your activity", color: .primary, size: 20, weight: .medium)
    
    let largetCalendarCard = LargeCalendarView()
    
    var formatter = DateFormatter()

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FPBackground
//        Router.presentController(from: self, to: GetStartedVC(), animated: false)
        
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
        setupCalendarCard()
    }
    
    fileprivate func setupCalendarCard() {
        view.addSubview(largetCalendarCard)
        largetCalendarCard.anchor(top: yourActivityLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                  paddingTop: 12, paddingLeft: 20, paddingRight: 20)
        
        largetCalendarCard.calendar.delegate = self
        largetCalendarCard.calendar.dataSource = self
    }

}


// MARK: Celendar Delegates
extension HomeVC: FSCalendarDataSource, FSCalendarDelegate{
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy E"
        print("Date Selected: \(formatter.string(from: date))")
    }
    
}

