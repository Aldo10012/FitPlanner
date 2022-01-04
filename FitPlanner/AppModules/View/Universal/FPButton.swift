//
//  FPButton.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

enum buttonType {
    case primary
    case secondary
    case calendar
}

class FPButton: UIButton {
    
    // MARK: init
    init(frame: CGRect = .zero,
         type: buttonType,
         title: String,
         size: CGFloat = 18,
         weight: UIFont.Weight = .bold,
         target: Any? = nil,
         action: Selector? = nil,
         radius: CGFloat = 5)
    {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
        layer.cornerRadius = radius
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        setStyle(type)
    }
    
    // MARK: - Helpers
    func setStyle(_ style: buttonType) {
        switch style {
        case .primary:
            setPrimaryStyle()
        case .secondary:
            setSecondaryStyle()
        case .calendar:
            calendarStyle()
        }
    }
    
    // MARK: Primary
    func setPrimaryStyle() {
        checkPrimaryStatus()
        setTitleColor(.white, for: .normal)
        setConstantHeight(height: 40)
        self.layer.cornerRadius = 20
    }
    
    func checkPrimaryStatus() {
        if isEnabled{
            backgroundColor = .FPBlue
        } else {
            backgroundColor = .FPBlueAlpha
        }
    }
    
    // MARK: Secondary
    func setSecondaryStyle() {
        backgroundColor = .white
        setTitleColor(.FPBlue, for: .normal)
        layer.borderColor = UIColor.FPBlue.cgColor
        layer.borderWidth = 2
        setConstantHeight(height: 30)
        self.layer.cornerRadius = 15
    }
    
    // MARK: Day of Week
    func calendarStyle(){
        backgroundColor = .FPBackground
        setTitleColor(.FPBlue, for: .normal)
//        layer.cornerRadius = 25
        setConstantHeight(height: 35)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
