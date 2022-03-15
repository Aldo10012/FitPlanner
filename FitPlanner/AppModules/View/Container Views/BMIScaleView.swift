//
//  BMIScaleView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/15/22.
//

import UIKit

class BMIScaleView: UIView {
    
    // MARK: Properties
    let obesebar = UIView()
    let overweightBar = UIView()
    let normalBar = UIView()
    let underweightbar = UIView()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    // MARK: Helpers
    func configureUI() {
        setConstantHeight(height: 10)
        obesebar.setConstantHeight(height: 10)
        overweightBar.setConstantHeight(height: 10)
        normalBar.setConstantHeight(height: 10)
        underweightbar.setConstantHeight(height: 10)
        
        obesebar.backgroundColor = .FPObese
        overweightBar.backgroundColor = .FPOverWeight
        normalBar.backgroundColor = .FPNormalWeight
        underweightbar.backgroundColor = .FPUnderWeight
        
        addSubviews(obesebar, overweightBar, normalBar, underweightbar)
        obesebar.anchor(left: leftAnchor)
        obesebar.centerY(inView: self)
        obesebar.setWidth(as: widthAnchor, multiplier: 1)
        
        overweightBar.anchor(left: leftAnchor)
        overweightBar.centerY(inView: self)
        overweightBar.setWidth(as: widthAnchor, multiplier: 0.7618)
        
        normalBar.anchor(left: leftAnchor)
        normalBar.centerY(inView: self)
        normalBar.setWidth(as: widthAnchor, multiplier: 0.5236)
        
        underweightbar.anchor(left: leftAnchor)
        underweightbar.centerY(inView: self)
        underweightbar.setWidth(as: widthAnchor, multiplier: 0.2143)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
