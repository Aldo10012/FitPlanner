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

    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserData()
        setupViews()
    }
    
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubviews(profilePicView, userNameLabel, weightImageView, weightLabel, heightImageView, heightLabel)
        
        profilePicView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        userNameLabel.anchor(top: profilePicView.topAnchor, left: profilePicView.rightAnchor, paddingLeft: 26)
        
        weightImageView.anchor(top: userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, paddingTop: 7)
        weightLabel.anchor(left: weightImageView.rightAnchor, paddingLeft: 5)
        weightLabel.centerY(inView: weightImageView)
        
        heightImageView.anchor(left: weightLabel.rightAnchor, paddingLeft: 15)
        heightImageView.centerY(inView: weightImageView)
        
        heightLabel.anchor(left: heightImageView.rightAnchor, paddingLeft: 5)
        heightLabel.centerY(inView: weightImageView)
        
        
    }
    
    // MARK: Helpers
//    fileprivate func getUserData() {
//        viewModel.getUserData()
//    }

    
}
