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
    
    private var profileImage: UIImage?
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .FPOffBlack
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleToFill
        button.contentMode =  .scaleToFill
        button.isEnabled = true
        return button
    }()
    
    
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
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubview(card)
        card.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 25, paddingRight: 25, height: 530)
        card.centerY(inView: view)
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
    

    

}


// MARK: - UIImagePickerControllerDelegate

extension GetStartedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// grab image selected from imagePicker
        let image = info[.originalImage] as? UIImage
        
        /// set plusPhotoButtom to be that image
        profileImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.systemGray3.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 100/2
        
        dismiss(animated: true, completion: nil)
    }
}
