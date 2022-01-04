//
//  UIView-ext.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

extension UIView {
    
    func addShadow(color: UIColor, opacity: Float, x: CGFloat, y: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: x, height: y)
    }
}
