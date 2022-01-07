//
//  AddExerciseCard.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

class AddExerciseCardView: UIView {

    // MARK: Properties
    let mainLabel = FPLabel(title: "Exercises", color: .primary, size: 18, weight: .light, alignment: .center)
    let numberLabel = FPLabel(title: "#", color: .primary, size: 16, weight: .light, alignment: .center)
    let nameLabel = FPLabel(title: "name", color: .primary, size: 16, weight: .light, alignment: .center)
    let repsLabel = FPLabel(title: "reps", color: .primary, size: 16, weight: .light, alignment: .center)
    let setsLabel = FPLabel(title: "sets", color: .primary, size: 16, weight: .light, alignment: .center)
    var tableView = UITableView()
    
    let addExerciseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.tintColor = .FPBlue
        btn.setDimensions(height: 20, width: 20)
        return btn
    }()
    
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setupViews()
        backgroundColor = .white
        layer.cornerRadius = 8
    }
    
    // MARK: Helpers
    fileprivate func setupViews() {
        addSubviews(mainLabel, numberLabel, nameLabel, repsLabel, setsLabel)
        mainLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 15)
        numberLabel.anchor(top: mainLabel.bottomAnchor, left: mainLabel.leftAnchor, paddingTop: 22)
        nameLabel.anchor(top: numberLabel.topAnchor, left: numberLabel.leftAnchor, paddingLeft: 18)
        setsLabel.anchor(top: numberLabel.topAnchor, right: rightAnchor, paddingRight: 12, width: 60)
        repsLabel.anchor(top: numberLabel.topAnchor, right: setsLabel.leftAnchor, paddingRight: 0, width: 60)
        
        // adding tableView
        addSubview(tableView)
        tableView.anchor(top: numberLabel.bottomAnchor, left: numberLabel.leftAnchor, bottom: bottomAnchor, right: setsLabel.rightAnchor, paddingTop: 15, paddingBottom: 15)
        
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: CellId.exerciseCell)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    open func hasAddButton() {
        addSubviews(addExerciseButton)
        addExerciseButton.anchor(right: rightAnchor, paddingRight: 15)
        addExerciseButton.centerY(inView: mainLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
