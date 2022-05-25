//
//  GetStartedContentView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 5/25/22.
//

import UIKit

class GetStartedContentView: UIView {
    // MARK: - Properties
    let card = FPBackground(radius: 8)
    
    let captionLabel = FPLabel(title: "Welcome to FitPlanner", color: .primary, size: 22, weight: .light)
    
    let nameTextField = FPTextField(placeholder: "John Smith", keyboardType: .default)
    let heightTextField = FPTextField(placeholder: "132", keyboardType: .numberPad)
    let weightTextField = FPTextField(placeholder: "160", keyboardType: .numberPad)
    
    lazy var nameContainer = InputContainerView(label: "User name", textField: nameTextField)
    lazy var heightContainer = InputContainerView(label: "Height (in)", textField: heightTextField)
    lazy var weightContainer = InputContainerView(label: "Weight (lb)", textField: weightTextField)
    
    let getStartedButton = FPButton(type: .primary, title: "Get Started")
    
    var profileImage: UIImage?
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .FPOffBlack
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleToFill
        button.contentMode =  .scaleToFill
        button.isEnabled = true
        return button
    }()
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {        
        addSubview(card)
        card.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 25, paddingRight: 25, height: 530)
        card.centerY(inView: self)
        card.addStandardShadow()
                
        card.addSubview(captionLabel)
        captionLabel.anchor(top: card.topAnchor, paddingTop: 34)
        captionLabel.centerX(inView: card)
        
        card.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: captionLabel.bottomAnchor, paddingTop: 23, width: 100, height: 100)
        plusPhotoButton.centerX(inView: card)
        
        card.addSubview(nameContainer)
        nameContainer.anchor(top: plusPhotoButton.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 34, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [heightContainer, weightContainer])
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 20
        
        card.addSubview(stack)
        stack.anchor(top: nameContainer.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 34, paddingLeft: 24, paddingRight: 24)
        
        card.addSubview(getStartedButton)
        getStartedButton.anchor(top: stack.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 68, paddingLeft: 24, paddingRight: 24)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
