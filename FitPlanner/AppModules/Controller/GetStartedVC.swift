//
//  GetStartedVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class GetStartedVC: UIViewController {
    
    // MARK: - Properties
    
    let card = FPBackground(radius: 8)
    
    let captionLabel = FPLabel(title: "Welcome to FitPlanner", color: .primary, size: 22, weight: .light)
    
    let nameTextField = FPTextField(placeholder: "John Smith", keyboardType: .default)
    let heightTextField = FPTextField(placeholder: "132", keyboardType: .numberPad)
    let weightTextField = FPTextField(placeholder: "160", keyboardType: .numberPad)
    
    lazy var nameContainer = InputContainerView(label: "Full name", textField: nameTextField)
    lazy var heightContainer = InputContainerView(label: "Height (in)", textField: heightTextField)
    lazy var weightContainer = InputContainerView(label: "Weight (lb)", textField: weightTextField)
    
    let getStartedButton = FPButton(type: .primary, title: "Get Started", target: self, action: #selector(didTapButton))
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: Selectors
    @objc func didTapButton() {
        Router.dismissController(self)
    }
    
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubview(card)
        card.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 25, paddingRight: 25, height: 400)
        card.centerY(inView: view)
        card.addShadow(color: .black, opacity: 0.15, x: 0, y: 4, radius: 8)
        
        card.addSubview(captionLabel)
        captionLabel.anchor(top: card.topAnchor, paddingTop: 34)
        captionLabel.centerX(inView: card)
        
        card.addSubview(nameContainer)
        nameContainer.anchor(top: captionLabel.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 34, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [heightContainer, weightContainer])
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 20
        
        card.addSubview(stack)
        stack.anchor(top: nameContainer.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 34, paddingLeft: 24, paddingRight: 24)
        
        card.addSubview(getStartedButton)
        getStartedButton.anchor(top: stack.bottomAnchor, left: card.leftAnchor, right: card.rightAnchor, paddingTop: 68, paddingLeft: 24, paddingRight: 24)
    }
    

    

}
