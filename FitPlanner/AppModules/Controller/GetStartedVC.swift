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
    var viewModel = GetStartedVM()
    var getStartedDelegate: GetStartedDelegate!
    var contentView = GetStartedContentView()
    
    var photoAuthStatus: PHAuthorizationStatus!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupPhotoAccess()
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
extension GetStartedVC {
    func setupPhotoAccess() {
        // Request permission to access photo library
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }
    }
    
    func showUI(for status: PHAuthorizationStatus) {
        
        self.photoAuthStatus = status
        
        switch status {
        case .authorized:
            showFullAccessUI()

        case .limited:
            showLimittedAccessUI()

        case .restricted:
            showRestrictedAccessUI()

        case .denied:
            showAccessDeniedUI()

        case .notDetermined:
            break

        @unknown default:
            break
        }
    }
    
    func showFullAccessUI() {
        print("full access")
        let photoCount = PHAsset.fetchAssets(with: nil).count
    }
    
    func showLimittedAccessUI() {
        print("limited access")
        let photoCount = PHAsset.fetchAssets(with: nil).count
        print("Photo count:", photoCount)
    }
    
    func showRestrictedAccessUI() {
        print("Restricted access")
    }
    
    func showAccessDeniedUI() {
        print("access denied")
    }
    
    
    /*
     "Select Photos" -> limited access -> authorized
     "Allow access to all photos" -> full access -> authorized
     "Dont't allow" -> access denied -> denied
     */
}
