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
    var viewModel = HomeVM()
    let getStartedDelegate = self
    
    let nextWorkoutLabel = FPLabel(title: "Your next workout", color: .primary, size: 20, weight: .medium)
    let nextWorkoutCard: NextWorkoutCard = {
        let view = NextWorkoutCard()
        view.viewButton.addTarget(self, action: #selector(didTapViewNextWorkoutButton), for: .touchUpInside)
        return view
    }()
    let yourActivityLabel = FPLabel(title: "Your activity", color: .primary, size: 20, weight: .medium)
    
    let largetCalendarCard = LargeCalendarView()
    
    var formatter = DateFormatter()

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let udManager = UserDefaultManager()
        if udManager.checkIfUserIsRegistered() {
            setupUI()
            updateUI()
        } else {
            let getStartedVC = GetStartedVC()
            getStartedVC.getStartedDelegate = self
            Router.presentController(from: self, to: getStartedVC, animated: false)
        }
        
//        var formattedDate = formatter.dateFormat = "eeee"
//        print("\(formatter.string(from: Date.today()))")
        
//        let mydata = CoreDataStack()
//        print(mydata.getNextWorkout())
        
    }

    
    // MARK: Selectors
    @objc func didTapViewNextWorkoutButton() {
        /// need to pass viewModel of type WorkoutCardVM
        print("tap next workout\n", self.viewModel.nextWorkout)
        Router.pushToWorkoutPlan(from: self, type: .nextWorkout, viewModel: self.viewModel.nextWorkout)
    }
    
    
    // MARK: UI Setup
    fileprivate func setupUI() {
        view.backgroundColor = .FPBackground
        
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
    
    fileprivate func updateUI() {
        viewModel.updateNextWorkoutCard { result in
            switch result {
            case let .success(x):
                DispatchQueue.main.async {
                    self.nextWorkoutCard.workoutNameLabel.text! = self.viewModel.nextWorkout.title
                }
                break
            case let.failure(y):
                break
            }
        }
        
        viewModel.updateActivityCalendar {
            DispatchQueue.main.async {
                for activity in self.viewModel.activity! {
                    self.largetCalendarCard.calendar.select(activity.date)
                }
            }
        }
    }

}


// MARK: Celendar Delegates
extension HomeVC: FSCalendarDataSource, FSCalendarDelegate{
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy E"
        print("Date Selected: \(formatter.string(from: date))")
    }
    
}


// MARK: GetStartedDelegate
extension HomeVC: GetStartedDelegate {
    func didRegister() {
        setupUI()
        updateUI()
    }
}
