//
//  SmallCalandarCard.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class SmallCalandarView: UIView {
    
    // MARK: Properties
    var label = FPLabel(title: "Workout Name", color: .primary, size: 18, weight: .regular)
    
    var SunButton = FPWeekButton(title: "S")
    var MonButton = FPWeekButton(title: "M")
    var TueButton = FPWeekButton(title: "T")
    var WedButton = FPWeekButton(title: "W")
    var ThuButton = FPWeekButton(title: "Th")
    var FriButton = FPWeekButton(title: "F")
    var SatButton = FPWeekButton(title: "Sa")
    
    let navButton = FPButton(type: .primary, title: "...")
    

    init(header: String) {
        super.init(frame: .zero)
        
        self.label.text = header
        navButton.setTitleColor(.black, for: .normal)
        navButton.backgroundColor = .clear
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .white
        addShadow(color: .black, opacity: 0.15, x: 0, y: 4, radius: 8)
        layer.cornerRadius = 8
        
        let stack = UIStackView(arrangedSubviews: [SunButton, MonButton, TueButton, WedButton, ThuButton, FriButton, SatButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        addSubviews(label, navButton, stack)
        
        label.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 15)
        navButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 0, paddingRight: 15)
        
        stack.anchor(top: label.bottomAnchor, left: label.leftAnchor, right: navButton.rightAnchor, paddingTop: 20)
        
        setConstantHeight(height: 127)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
