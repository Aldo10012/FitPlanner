//
//  LargeWidgetView.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI

struct LargeWidgetEntryView : View {
    var entry: LargeWidgetTimeline.Entry

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack() {
                    Text(entry.nextWorkoutName)
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    Text(entry.nextWorkoutDate)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.init(uiColor: .FPLableTertiary))
                }.padding(.bottom, 15)
                
                HStack() {
                    Text("\(entry.numberOfExercises)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.init(uiColor: .FPBlue))
                    Text("Exercises")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color.init(uiColor: .FPLabelPrimary))
                    Spacer()
                    DaysOfWeekView(entry: entry)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.top, -8)
                
                VStack(alignment: .leading, spacing: 2) {
                    LargeWidgetExerciseRowView(name: "name", reps: "reps", sets: "sets")
                        .padding(.bottom, 7)
                    
                    ForEach(self.getListOfExercises(), id: \.self) { (exercise) in
                        LargeWidgetExerciseRowView(
                            name: exercise.name ?? "no name",
                            reps: "\(exercise.reps)",
                            sets: "\(exercise.sets)"
                        )
                    }
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }.padding()
            
        
    }
    
    func getListOfExercises() -> [Exercise] {
        let listOfExercises = entry.nextWorkout?.exercises?.allObjects as! [Exercise]
        return listOfExercises
    }
}

struct DaysOfWeekView: View {
    @State var entry: LargeWidgetTimeline.Entry
    
    var body: some View {
        HStack(spacing: 6) {
            Text("S")
                .foregroundColor(entry.onSun ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("M")
                .foregroundColor(entry.onMon ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("T")
                .foregroundColor(entry.onThu ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("W")
                .foregroundColor(entry.onWed ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("Th")
                .foregroundColor(entry.onThu ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("F")
                .foregroundColor(entry.onFri ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
            Text("Sa")
                .foregroundColor(entry.onSat ? Color.init(uiColor: .FPBlue) : Color.init(uiColor: .FPLabelPrimary))
        }
        .font(.system(size: 14, weight: .medium))
    }
}

struct LargeWidgetExerciseRowView: View {
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
