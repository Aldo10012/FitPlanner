//
//  FPBackground.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FPBackground: UIView {

    init(frame: CGRect = .zero, radius: CGFloat = 0){
        super.init(frame: frame)
        
        setAutoLayout()
        self.layer.cornerRadius = radius
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
