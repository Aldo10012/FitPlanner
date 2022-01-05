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
    convenience init(viewModel: SmallCalandarVM) {
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
        workoutCard.anchor(left: leftAnchor, right: rightAnchor)
        workoutCard.centerY(inView: self)
    }
    
    public func setViewModel(as viewModel: SmallCalandarVM) {
        self.workoutCard = WorkoutCardView(viewModel: viewModel)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
