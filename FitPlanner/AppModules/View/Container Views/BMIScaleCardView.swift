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
    
    var slider: UISlider = {
        let s = UISlider()
        s.thumbTintColor = .white
        s.minimumTrackTintColor = .clear
        s.maximumTrackTintColor = .clear
        s.minimumValue = 14
        s.maximumValue = 35
        s.isUserInteractionEnabled = false
        return s
    }()
    
    var bmiBar = BMIScaleView()
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    
    func configureUI() {
        backgroundColor = .clear
        layer.cornerRadius = 8
        
        addSubviews(label, card)
        card.addSubviews(bmiLabel, detailLabel, bmiBar)
        
        label.anchor(top: topAnchor, left: leftAnchor)
        card.anchor(top: label.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15)
        card.setConstantHeight(height: 115)
        card.addStandardShadow()
        
        bmiLabel.anchor(top: card.topAnchor, left: card.leftAnchor, paddingTop: 10, paddingLeft: 15)
        detailLabel.anchor(left: bmiLabel.rightAnchor, bottom: bmiLabel.bottomAnchor, paddingLeft: 10)
        
        
        bmiBar.anchor(top: bmiLabel.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        bmiBar.addSubview(slider)
        slider.anchor(left: bmiBar.leftAnchor, right: bmiBar.rightAnchor)
        slider.centerY(inView: bmiBar)
        
        
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        
    }
    
    func updateContent(bmi: Double) {
        bmiLabel.text = "\(bmi)"
        detailLabel.text = BMIMannager.getBMIScaleDescription(bmi: bmi)
        slider.value = Float(bmi)
    }
    
    
    //let step:Float = 10
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        print("Slider value changed")
            
        let value = round(sender.value * 100) / 100 //(sender.value)
            
        print("Slider step value \(value)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
