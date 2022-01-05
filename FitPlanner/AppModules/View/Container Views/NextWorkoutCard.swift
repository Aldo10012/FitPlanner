//
//  NextWorkoutCard.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class NextWorkoutCard: UIView {

    // MARK: - Properties
    let imgView = UIImageView(image: UIImage(systemName: "bicycle.circle.fill"))
    var workoutNameLabel = FPLabel(title: "Upper Split", color: .primary, size: 18, weight: .light)
    var dateLabel = FPLabel(title: "Today, Jan 4", color: .primary, size: 12, weight: .medium)
    let viewButton = FPButton(type: .secondary, title: "view")
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        
        setupUI()
    }
    
    // MARK: UI Setup
    fileprivate func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 8
        setConstantHeight(height: 84)
        addStandardShadow()
        
        addSubview(imgView)
        imgView.setDimensions(height: 60, width: 60)
        imgView.anchor(left: leftAnchor, paddingLeft: 16)
        imgView.centerY(inView: self)
        imgView.image?.withRenderingMode(.alwaysOriginal)
        imgView.tintColor = .FPBlue
        
        addSubview(workoutNameLabel)
        workoutNameLabel.anchor(top: imgView.topAnchor, left: imgView.rightAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(left: imgView.rightAnchor, bottom: imgView.bottomAnchor, paddingLeft: 16, paddingBottom: 10)
        
        addSubview(viewButton)
        viewButton.anchor(right: rightAnchor, paddingRight: 16, width: 75)
        viewButton.centerY(inView: self)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
