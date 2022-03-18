//
//  WIdgetBundle.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import WidgetKit
import SwiftUI
import Intents

//@main
struct FPWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        SmallWidget()
        MediumWidget()
        LargeWidget()
    }
}
