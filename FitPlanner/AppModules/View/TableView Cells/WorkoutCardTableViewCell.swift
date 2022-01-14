//
//  WorkoutCardTableViewCell.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

class WorkoutCardTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var workoutCard: WorkoutCardView!

    
    // MARK: Init
    convenience init(viewModel: WorkoutCardVM) {
        self.init()
        
        self.workoutCard = WorkoutCardView(viewModel: viewModel)
        setupViews()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        setupViews()
    }
    
    
    // MARK: Helpers
    fileprivate func setupViews() {
        addSubview(workoutCard)
        backgroundColor = .clear
        workoutCard.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        workoutCard.centerY(inView: self)
    }
    
    public func setViewModel(as viewModel: WorkoutCardVM) {
        self.workoutCard = WorkoutCardView(viewModel: viewModel)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
