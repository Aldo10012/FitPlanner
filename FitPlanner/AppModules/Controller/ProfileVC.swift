//
//  ThirdVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: Properties
    var viewModel = ProfileVM()

    var profilePic: UIImage? = UIImage(systemName: "person")
    
    lazy var profilePicView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = profilePic!
        imgView.contentMode = .scaleAspectFit
        
        imgView.clipsToBounds = true
        imgView.tintColor = .FPOffBlack
        imgView.backgroundColor = .gray
        imgView.layer.cornerRadius = 30
        imgView.setDimensions(height: 60, width: 60)
        return imgView
    }()
    
    let weightImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "weight_photo")!
        imgView.tintColor = .FPOffBlack
        imgView.setDimensions(height: 20, width: 20)
        return imgView
    }()
    
    let heightImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "height_photo")!
        imgView.tintColor = .FPOffBlack
        imgView.setDimensions(height: 20, width: 20)
        return imgView
    }()
    
    var userNameLabel = FPLabel(title: "Name", color: .primary, size: 22, weight: .light)
    var weightLabel = FPLabel(title: "0 lbs", color: .primary, size: 16, weight: .light)
    var heightLabel = FPLabel(title: "0 in", color: .primary, size: 16, weight: .light)
    let logWeightButton = FPButton(type: .primary, title: "Log weight", target: self, action: #selector(didTapLogWeight))
    
    var bmiCard = BMIScaleCardView()
    
    // Picker
    var pickerView: UIPickerView!
    var pickerData: [Int]!

    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        setupViews()
    }
    
    // MARK: Selectors
    @objc func didTapLogWeight() {
        setupPicker()
        showAlert()
    }
    
    @objc func handleSeeHistoryTap(_ sender: UITapGestureRecognizer) {
        print("DID TAP")
        Router.pushToController(BMILogVC(), from: self)
    }
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubviews(profilePicView, userNameLabel, weightImageView, weightLabel, heightImageView, heightLabel, bmiCard, logWeightButton)
        
        profilePicView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        userNameLabel.anchor(top: profilePicView.topAnchor, left: profilePicView.rightAnchor, paddingLeft: 26)
        
        weightImageView.anchor(top: userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, paddingTop: 7)
        weightLabel.anchor(left: weightImageView.rightAnchor, paddingLeft: 5)
        weightLabel.centerY(inView: weightImageView)
        
        heightImageView.anchor(left: weightLabel.rightAnchor, paddingLeft: 15)
        heightImageView.centerY(inView: weightImageView)
        
        heightLabel.anchor(left: heightImageView.rightAnchor, paddingLeft: 5)
        heightLabel.centerY(inView: weightImageView)
        
        bmiCard.anchor(top: profilePicView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        
        logWeightButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        
        bmiCard.seeHistoryLabel.isUserInteractionEnabled = true
        
        let seeHistoryTap = UITapGestureRecognizer(target: self, action: #selector(handleSeeHistoryTap))
        bmiCard.seeHistoryLabel.addGestureRecognizer(seeHistoryTap)
    }
    
    // MARK: Helpers
    fileprivate func getUserData() {
        viewModel.updateProfile { [weak self] vm in
            self!.profilePic = vm?.profilePic
            self!.userNameLabel.text = vm?.userName
            self!.weightLabel.text = "\((vm?.weight)!) lbs"
            self!.heightLabel.text = "\((vm?.feet)!)' \((vm?.inches)!)'' ft"
            
            self!.bmiCard.updateContent(bmi: (vm?.bmi)!)            
        }
    }
    
    fileprivate func bmiWasUpdated(with newWeight: Double) {
        viewModel.updateBMI(newWeight: newWeight)
        getUserData()
    }
    
    fileprivate func setupPicker() {
        pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // This is where you can set your min/max values
        let minNum = 1
        let maxNum = 300
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 1))
    }
    
    fileprivate func showAlert() {
        FPAlert.showUpdateWeightAlert(on: self, pickerView: pickerView, pickerData: pickerData, weight: viewModel.weight!) {
            let pickerValue = self.pickerData[self.pickerView.selectedRow(inComponent: 0)]
            print("Picker value: \(pickerValue) was selected")
            self.bmiWasUpdated(with: Double(pickerValue))
        }
    }
}

// MARK: UIPickerView Delegates
extension ProfileVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row])"
    }
}
