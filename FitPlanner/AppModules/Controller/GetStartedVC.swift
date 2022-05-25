//
//  GetStartedVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit
import PhotosUI

protocol GetStartedDelegate {
    func didRegister()
}

class GetStartedVC: UIViewController {
    
    // MARK: - Properties
    let udManager = UserDefaultManager()
    var photoManager = PhotoAccessManger()
    var viewModel = GetStartedVM()
    var getStartedDelegate: GetStartedDelegate!
    var contentView = GetStartedContentView()
        
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        photoManager.setupPhotoAccess()
    }
    
    
    // MARK: Selectors
    @objc func didTapButton() {
        viewModel.registerUser() // register user in CoreData
        udManager.registerUser() // set user as registered in UserDefaults
        
        getStartedDelegate.didRegister()
        Router.dismissController(self)
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("authorized")
            present(imagePickerController, animated: true, completion: nil)
            
        case .denied:
            print("denied")
            // TODO: give profile pic a placeholder so it's not nil
        
        default:
            break
        }
    }
    
    
    // MARK: Action Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubviews(contentView)
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        contentView.getStartedButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        contentView.plusPhotoButton.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        photoManager.delegate = self
        contentView.nameTextField.delegate = self
        contentView.heightTextField.delegate = self
        contentView.weightTextField.delegate = self
        contentView.nameTextField.returnKeyType = .next
    }
    
    
    // MARK: Helpers
    func checkFormStatus() {
        if viewModel.formIsValid{
            contentView.getStartedButton.isEnabled = true
            contentView.getStartedButton.checkPrimaryStatus()
        } else {
            contentView.getStartedButton.isEnabled = false
            contentView.getStartedButton.checkPrimaryStatus()
        }
    }
}


// MARK: UITextFieldDelegate
extension GetStartedVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case contentView.nameTextField:
            viewModel.userName = contentView.nameTextField.text
        case contentView.heightTextField:
            viewModel.height = Double(contentView.heightTextField.text!)
        case contentView.weightTextField:
            viewModel.weight = Double(contentView.weightTextField.text!)
        default:
            break
        }
        
        print(viewModel)
        checkFormStatus()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case contentView.nameTextField:
            contentView.heightTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
}


// MARK: - UIImagePickerControllerDelegate

extension GetStartedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// grab image selected from imagePicker
        let image = info[.originalImage] as? UIImage
        
        /// set plusPhotoButtom to be that image
        contentView.profileImage = image
        contentView.plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        contentView.plusPhotoButton.layer.borderColor = UIColor.systemGray3.cgColor
        contentView.plusPhotoButton.layer.borderWidth = 3.0
        contentView.plusPhotoButton.layer.cornerRadius = 100/2
        
        viewModel.pictureIsSelected = true
        viewModel.pictureData = image?.pngData()
        checkFormStatus()
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Photo Library
extension GetStartedVC: PhotoAccessManagerDelegate {
    
    // These method's don't really do anything right now, but if we want some kind of UI update to happen when a user selects a photo library auroization level, we would call these.
    
    func showFullAccessUI() {}
    func showLimittedAccessUI() {}
    func showRestrictedAccessUI() {}
    func showAccessDeniedUI() {}
}
