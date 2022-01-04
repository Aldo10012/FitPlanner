//
//  InputContainerView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class InputContainerView: UIView {

    // MARK: - Properties
    let titleLabel = FPLabel(title: "label", size: 16, weight: .medium)
    let inputBox = FPBackground(radius: 20)
    var mainTextField = FPTextField(placeholder: "")
    
    // MARK: - Init
    init(label: String, textField: FPTextField){
        super.init(frame: .zero)
        
        titleLabel.text = label
        mainTextField = textField
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor)
        
        addSubview(inputBox)
        inputBox.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5)
        inputBox.setConstantHeight(height: 40)
        inputBox.layer.borderWidth = 1
        inputBox.layer.borderColor = UIColor.systemGray.cgColor
        inputBox.backgroundColor = UIColor.clear
        
        inputBox.addSubview(mainTextField)
        mainTextField.anchor(left: inputBox.leftAnchor, right: inputBox.rightAnchor, paddingLeft: 13, paddingRight: 13)
        mainTextField.centerY(inView: inputBox)
        mainTextField.setHeight(as: inputBox.heightAnchor)
        
        let placeholderText = NSAttributedString(
            string: mainTextField.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        mainTextField.attributedPlaceholder = placeholderText
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
