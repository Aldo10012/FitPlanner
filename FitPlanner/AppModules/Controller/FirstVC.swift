//
//  ViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FirstVC: UIViewController {
    
    // MARK: Properties
    let nextWorkoutLabel = FPLabel(title: "Your next workout", color: .primary, size: 18, weight: .medium)
    let nextWorkoutCard = NextWorkoutCard()

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FPBackground
        Router.presentController(from: self, to: GetStartedVC(), animated: false)
        
        setupUI()
    }

    
    // MARK: UI Setup
    fileprivate func setupUI() {
        
        view.addSubview(nextWorkoutLabel)
        nextWorkoutLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40, paddingLeft: 20)
        
        view.addSubview(nextWorkoutCard)
        nextWorkoutCard.anchor(top: nextWorkoutLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingRight: 20)
    }

}

