//
//  ExerciseTableViewCell.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

/*
 Create protocol between ExerciseTableViewCell & WorkoutVC
 
 
 */


protocol ExerciseDelegate {
    func didUpdateName(indexPath: Int?, name: String?)
    func didUpdateSets(indexPath: Int?, sets: Int64?)
    func didUpdateReps(indexPath: Int?, reps: Int64?)
}

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var delegate: ExerciseDelegate!
    
    var numberLabel = FPLabel(title: "0", color: .primary, size: 16, weight: .light, alignment: .center)
    var nameTextField = FPTextField(placeholder: "name", size: 16, weight: .light, keyboardType: .default, textAlignment: .left)
    var repsTextField = FPTextField(placeholder: "0", size: 16, weight: .light, keyboardType: .numberPad, textAlignment: .center)
    var setsTextField = FPTextField(placeholder: "0", size: 16, weight: .light, keyboardType: .numberPad, textAlignment: .center)

    
    // MARK: Init
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    
    // MARK: Helpers
    
    fileprivate func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(numberLabel, nameTextField, repsTextField, setsTextField)
        
        for view in [numberLabel, nameTextField, repsTextField, setsTextField] {
            view.centerY(inView: contentView)
        }
        
        numberLabel.anchor(left: contentView.leftAnchor)
        nameTextField.anchor(left: numberLabel.rightAnchor, paddingLeft: 18)
        
        setsTextField.anchor(right: contentView.rightAnchor)
        setsTextField.setConstantWidth(width: 60)
        repsTextField.anchor(right: setsTextField.leftAnchor)
        repsTextField.setConstantWidth(width: 60)
        
        nameTextField.addTarget(self, action: #selector(didChangeName), for: .editingChanged)
        setsTextField.addTarget(self, action: #selector(didChangeSets), for: .editingChanged)
        repsTextField.addTarget(self, action: #selector(didChangeReps), for: .editingChanged)
    }
    
    
    // MARK: Selectors
    @objc func didChangeName() {
        delegate.didUpdateName(
            indexPath: Int(numberLabel.text!)! - 1,
            name: nameTextField.text
        )
    }
    
    @objc func didChangeSets() {
        let setsAmount: Int64
        if setsTextField.text == "" {
            setsAmount = 0
        } else {
            setsAmount = Int64(setsTextField.text!)!
        }
        
        delegate.didUpdateSets(
            indexPath: Int(numberLabel.text!)! - 1,
            sets: setsAmount
        )
    }
    
    @objc func didChangeReps() {
        let repsAmount: Int64
        if repsTextField.text == "" {
            repsAmount = 0
        } else {
            repsAmount = Int64(repsTextField.text!)!
        }
        delegate.didUpdateReps(
            indexPath: Int(numberLabel.text!)! - 1,
            reps: repsAmount
        )
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
