//
//  ExerciseTableViewCell.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let numberLabel = FPLabel(title: "0", color: .primary, size: 14, weight: .light, alignment: .center)
    var nameTextField = FPTextField(placeholder: "0", size: 14, weight: .light, keyboardType: .default)
    var repsTextField = FPTextField(placeholder: "0", size: 14, weight: .light, keyboardType: .numberPad)
    var setsTextField = FPTextField(placeholder: "0", size: 14, weight: .light, keyboardType: .numberPad)

    
    // MARK: Init
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    // MARK: Helpers
    fileprivate func setupViews() {
        addSubviews(numberLabel, nameTextField, repsTextField, setsTextField)
        
        for view in [numberLabel, nameTextField, repsTextField, setsTextField] {
            view.centerY(inView: self)
        }
        
        numberLabel.anchor(left: leftAnchor)
        nameTextField.anchor(left: numberLabel.leftAnchor, paddingLeft: 18)
        setsTextField.anchor(left: leftAnchor, right: leftAnchor, paddingLeft: -30)
        repsTextField.anchor(left: setsTextField.leftAnchor, right: setsTextField.leftAnchor, paddingLeft: -30)
        
        setConstantHeight(height: 20)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
