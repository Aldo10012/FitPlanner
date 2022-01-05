//
//  SecondViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class SecondVC: UIViewController {

    // MARK: Properties
    let yourWorkoutsLabel = FPLabel(title: "Your next workout", color: .primary, size: 20, weight: .medium)
    let workoutCard = SmallCalandarView(header: "Workout A")
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubview(yourWorkoutsLabel)
        yourWorkoutsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40, paddingLeft: 20)
        
        view.addSubview(workoutCard)
        workoutCard.anchor(top: yourWorkoutsLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingRight: 20)
    }
}
