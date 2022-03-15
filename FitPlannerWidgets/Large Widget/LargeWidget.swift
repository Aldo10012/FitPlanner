//
//  LargeWidget.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI


struct LargeWidget: Widget {
    let kind: String = "FitPlannerWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LargeWidgetTimeline()) { entry in
            LargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Large Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidgetEntryView(entry: LargeWidgetEntry(
            date: Date(),
            nextWorkoutName: "Full Body A",
            nextWorkoutDate: getDateAsStringLong(Date()) + ",\n" + getMonthAndDateAsString(Date())
        ))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
