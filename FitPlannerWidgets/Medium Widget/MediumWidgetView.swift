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
                
                Text(entry.nextWorkoutName)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(Color(UIColor.FPOffBlack))
                    .padding(.bottom, 5)
                
                Text("\(entry.nextWorkoutDate)")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(Color(UIColor.FPTextFieldPlaceholder))
                    .padding(.bottom, 10)
                
                Spacer()
                
                Text("\(entry.numberOfExercises) Exercises")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(Color(UIColor.FPOffBlack))
                    .padding(.bottom, 10)
            }
            VStack(alignment: .leading) {
                MediumWidgetExerciseRowView(name: "name", reps: "reps", sets: "sets")
                
                ForEach(self.getListOfExercises(), id: \.self) { (exercise) in
                    MediumWidgetExerciseRowView(
                        name: exercise.name ?? "no name",
                        reps: "\(exercise.reps)",
                        sets: "\(exercise.sets)"
                    )
                }
                Spacer()
            }
            .padding(.leading, 20)
            
            Spacer()
        }.padding()
            
        
    }
    
    func getListOfExercises() -> [Exercise] {
        let listOfExercises = entry.nextWorkout?.exercises?.allObjects as [Exercise]
        return listOfExercises
    }
}


struct MediumWidgetExerciseRowView: View {
    @State var name: String
    @State var reps: String
    @State var sets: String
    
    var body: some View {
        HStack() {
            Text("\(name)")
            Spacer()
            Text("\(reps)")
                .frame(width: 36, alignment: .center)
            Text("\(sets)")
                .frame(width: 36, alignment: .center)
        }
    }
}
