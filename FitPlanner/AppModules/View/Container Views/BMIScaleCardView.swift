//
//  BMIScaleCardView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/15/22.
//

import UIKit

class BMIScaleCardView: UIView {
    
    // MARK: Properties
    var label = FPLabel(title: "BMI Calculator", color: .primary, size: 18, weight: .regular)
    let card = FPBackground(radius: 8)
    var bmiLabel = FPLabel(title: "0.0", color: .primary, size: 22, weight: .bold)
    var detailLabel = FPLabel(title: "Detail", color: .primary, size: 16, weight: .thin)
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    
    func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        
        addSubviews(label, card)
        card.addSubviews(bmiLabel, detailLabel)
        
        label.anchor(top: topAnchor, left: leftAnchor)
        card.anchor(top: label.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15)
        card.setConstantHeight(height: 115)
        
        bmiLabel.anchor(top: card.topAnchor, left: card.leftAnchor, paddingTop: 10, paddingLeft: 15)
        detailLabel.anchor(left: bmiLabel.rightAnchor, bottom: bmiLabel.bottomAnchor, paddingLeft: 10)
    }
    
    func updateContent(bmi: Double) {
        bmiLabel.text = "\(bmi)"
        detailLabel.text = BMIMannager.getBMIScaleDescription(bmi: bmi)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
