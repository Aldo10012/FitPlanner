//
//  ExerciseTableViewCell.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let numberLabel = FPLabel(title: "0", color: .primary, size: 16, weight: .light, alignment: .center)
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
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
