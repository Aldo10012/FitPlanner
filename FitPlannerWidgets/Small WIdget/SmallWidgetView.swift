//
//  SmallWidgetView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import WidgetKit
import SwiftUI

struct SmallWidgetEntryView : View {
    var entry: SmallWidgetTimeline.Entry
    var viewModel = SmallWidgetViewModel()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Next Workout")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(Color(UIColor.FPBlue))
                    .padding(.bottom, 5)
                
                Text(viewModel.nextWorkoutName)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .foregroundColor(Color(UIColor.FPOffBlack))
                    .padding(.bottom, 20)
                
                Text(viewModel.nextWorkoutDate)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(Color(UIColor.FPTextFieldPlaceholder))
                    .padding(.bottom, 10)
                Spacer()
            }
            Spacer()
        }.padding()
            
        
    }
}

class SmallWidgetViewModel: ObservableObject {
    let myData = CoreDataStack.shared
    @Published var nextWorkoutName = ""
    @Published var nextWorkoutDate = ""
    init() {
        getNextWorkout()
    }
    func getNextWorkout() {
        guard let nextWorkout = myData.getNextWorkout() else {
            nextWorkoutName = "Workout Name"
            nextWorkoutDate = "Today, \nJun 12"
            return
        }
        print(nextWorkout)
        nextWorkoutName = nextWorkout.name!
        nextWorkoutDate = getDateAsStringLong(dateOfNextWorkout)
        
    }
}
