//
//  FitPlannerWidgets.swift
//  FitPlannerWidgets
//
//  Created by Alberto Dominguez on 1/11/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct FitPlannerWidgetsEntryView : View {
    var entry: Provider.Entry
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

@main
struct FitPlannerWidgets: Widget {
    let kind: String = "FitPlannerWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FitPlannerWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct FitPlannerWidgets_Previews: PreviewProvider {
    static var previews: some View {
        FitPlannerWidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
