//
//  SmallCalandarCard.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class WorkoutCardView: UIView {
    
    // MARK: Properties
    var label = FPLabel(title: "Workout Name", color: .primary, size: 18, weight: .regular)
    
    var SunButton = FPWeekButton(title: "S")
    var MonButton = FPWeekButton(title: "M")
    var TueButton = FPWeekButton(title: "T")
    var WedButton = FPWeekButton(title: "W")
    var ThuButton = FPWeekButton(title: "Th")
    var FriButton = FPWeekButton(title: "F")
    var SatButton = FPWeekButton(title: "Sa")
    
    let navButton = FPButton(type: .primary, title: "...")
    
    var smalllCardViewModel: WorkoutCardVM!

    init(viewModel: WorkoutCardVM) {
        super.init(frame: .zero)
        
        self.smalllCardViewModel = viewModel
        
        self.label.text = smalllCardViewModel.title
        
        if smalllCardViewModel.onSun { SunButton.workoutIsScheduled = true }
        if smalllCardViewModel.onMon { MonButton.workoutIsScheduled = true }
        if smalllCardViewModel.onTue { TueButton.workoutIsScheduled = true }
        if smalllCardViewModel.onWed { WedButton.workoutIsScheduled = true }
        if smalllCardViewModel.onThu { ThuButton.workoutIsScheduled = true }
        if smalllCardViewModel.onFri { FriButton.workoutIsScheduled = true }
        if smalllCardViewModel.onSat { SatButton.workoutIsScheduled = true }
        
        navButton.setTitleColor(.black, for: .normal)
        navButton.backgroundColor = .clear
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .white
        addStandardShadow()
        layer.cornerRadius = 8
        
        let stack = UIStackView(arrangedSubviews: [SunButton, MonButton, TueButton, WedButton, ThuButton, FriButton, SatButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        addSubviews(label, navButton, stack)
        
        label.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 15)
        navButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 0, paddingRight: 15)
        
        stack.anchor(top: label.bottomAnchor, left: label.leftAnchor, right: navButton.rightAnchor, paddingTop: 20)
        
        setConstantHeight(height: 127)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
