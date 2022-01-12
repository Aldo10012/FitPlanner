//
//  UIColor-ext.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

extension UIColor {
    
    static public func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static var FPBackground = rgba(248, 248, 248, 1)
    
    static var FPBlue = rgba(86, 204, 242, 1)
    static var FPBlueAlpha = rgba(86, 204, 242, 0.5)
    
    static var FPOffBlack = rgba(62, 62, 62, 1)
    
    // colors specific to FPLabel
    static var FPLabelPrimary = rgba(62, 62, 62, 1)
    
    // colors spedific to FPTextField
    static var FPTextFieldPlaceholder = rgba(187, 187, 187, 1)
    
    static var FPGray = rgba(238, 238, 238, 1)
    
    
    
    
}
