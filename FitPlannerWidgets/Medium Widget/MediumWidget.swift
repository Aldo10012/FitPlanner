//
//  MediumWidget.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/14/22.
//

import Foundation
import WidgetKit
import SwiftUI


struct MediumWidget: Widget {
    let kind: String = "FitPlannerWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MediumWidgetTimeline()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Medium Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetEntryView(entry: MediumWidgetEntry(
            date: Date(),
            nextWorkoutName: "Full Body A",
            nextWorkoutDate: getDateAsStringLong(Date()) + ",\n" + getMonthAndDateAsString(Date())
        ))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
