//
//  ViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FPBackground
        Router.presentController(from: self, to: GetStartedVC(), animated: false)
    }


}

