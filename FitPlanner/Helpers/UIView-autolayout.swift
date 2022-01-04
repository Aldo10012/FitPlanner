//
//  UIView-autolayout.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

extension UIView {
    
    // MARK: - Anchoring
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        setAutoLayout()
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        setAutoLayout()
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        setAutoLayout()
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        setAutoLayout()
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setConstantHeight(height: CGFloat) {
        setAutoLayout()
        heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    func setHeight(as anchor: NSLayoutDimension, multiplier: CGFloat = 1){
        setAutoLayout()
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
    }
    
    func setConstantWidth(width: CGFloat) {
        setAutoLayout()
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidth(as anchor: NSLayoutDimension, multiplier: CGFloat = 1){
        setAutoLayout()
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
    }
    
    func setAutoLayout(){
        translatesAutoresizingMaskIntoConstraints = false
    }

}
