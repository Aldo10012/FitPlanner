//
//  FPTextField.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class FPTextField: UITextField {
    
    init(frame: CGRect = .zero,
         placeholder: String,
         size: CGFloat = 16,
         weight: UIFont.Weight = .regular,
         color: UIColor = .FPOffBlack,
         tintColor: UIColor = .FPOffBlack,
         keyboardType: UIKeyboardType = .default,
         textAlignment: NSTextAlignment = .left,
         isSecure: Bool = false
    )

    {
        super.init(frame: frame)
        
        setAutoLayout()
        self.borderStyle = .none
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
        self.tintColor = tintColor
        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
//        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
                                                    [.foregroundColor : UIColor.FPTextFieldPlaceholder]
        )
        isSecureTextEntry = isSecure
        
    }
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
