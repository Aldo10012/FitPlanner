//
//  FPWeekButton.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FPWeekButton: UIButton {
    var scheduledWorkout: Bool

    init(title: String, workoutOnThisDay: Bool = false) {
        self.scheduledWorkout = workoutOnThisDay
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        layer.cornerRadius = 35/2
        setDimensions(height: 35, width: 35)
        checkIfWorkoutIsScheduled()
    }
    
    func checkIfWorkoutIsScheduled() {
        if scheduledWorkout {
            setTitleColor(.white, for: .normal)
            backgroundColor = .FPBlue
        } else {
            setTitleColor(.black, for: .normal)
            backgroundColor = .FPGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
