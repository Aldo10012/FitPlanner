//
//  FPWeekButton.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FPWeekButton: UIButton {
    
    // MARK: Properties
    var canEdit: Bool {
        didSet {
            checkIfWorkoutIsScheduled()
            checkIfWorkoutCanBeEdited()
        }
    }
    var workoutIsScheduled: Bool {
        didSet {
            checkIfWorkoutIsScheduled()
        }
    }

    
    // MARK: Init
    init(title: String, workoutOnThisDay: Bool = false, canEdit: Bool = false) {
        self.workoutIsScheduled = workoutOnThisDay
        self.canEdit = canEdit
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        layer.cornerRadius = 35/2
        setDimensions(height: 35, width: 35)
        
        checkIfWorkoutIsScheduled()
        checkIfWorkoutCanBeEdited()
    }
    
    
    // MARK: Helpers
    func checkIfWorkoutIsScheduled() {
        if workoutIsScheduled {
            setTitleColor(.white, for: .normal)
            backgroundColor = .FPBlue
        } else {
            setTitleColor(.black, for: .normal)
            backgroundColor = .FPGray
        }
    }
    
    func checkIfWorkoutCanBeEdited() {
        if canEdit {
            addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        }
    }
    
    
    // MARK: Selectors
    @objc func didTapBtn() {
        workoutIsScheduled.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
