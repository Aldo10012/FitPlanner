//
//  WorkoutPlanVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

enum WorkoutPlanType {
    case nextWorkout
    case addWorkout
    case editWorkout
}

class WorkoutPlanVC: UIViewController {

    // MARK: - Properties
    var type: WorkoutPlanType!
    
    
    
    convenience init(type: WorkoutPlanType) {
        self.init()
        self.type = type
    }
    
    
    // MARK: Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    

    
    // MARK: - UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        title = "Workout Plan"
    }
    

}
