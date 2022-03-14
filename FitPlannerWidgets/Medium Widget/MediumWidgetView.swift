//
//  MediumWidgetView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

struct MediumWidgetEntryView : View {
    var entry: MediumWidgetTimeline.Entry

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Next Workout")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(Color(UIColor.FPBlue))
                    .padding(.bottom, 5)
                
                Text(entry.nextWorkoutName)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .foregroundColor(Color(UIColor.FPOffBlack))
                    .padding(.bottom, 20)
                
                Text("\(entry.nextWorkoutDate)")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(Color(UIColor.FPTextFieldPlaceholder))
                    .padding(.bottom, 10)
                Spacer()
            }
            Spacer()
        }.padding()
            
        
    }
}
