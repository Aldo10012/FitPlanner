//
//  FPLabel.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

enum labelColor {
    case primary
    case secondary
    case tertiary
}

class FPLabel: UILabel{
    
    init(title: String,
         color: labelColor = .primary,
         size: CGFloat = 16,
         weight: UIFont.Weight = .regular,
         alignment: NSTextAlignment = .left,
         frame:CGRect = .zero)
    {
        super.init(frame: frame)
        
        setAutoLayout()
        self.text = title
        setColor(color)
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textAlignment = alignment
    }
    
    // MARK: - Helpers
    
    func setColor(_ color: labelColor) {
        switch color {
        case .primary:
            self.textColor = .FPLabelPrimary
        case .secondary:
            self.textColor = .white
        case .tertiary:
            self.textColor = .FPLableTertiary
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
