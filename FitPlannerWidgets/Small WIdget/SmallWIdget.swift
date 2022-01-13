//
//  SmallWIdget.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import WidgetKit
import SwiftUI

@main
struct SmallWidget: Widget {
    let kind: String = "FitPlannerWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SmallWidgetTimeline()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: SmallWidgetEntry(date: Date(), nextWorkoutName: "Hello", nextWorkoutDate: getDateAsStringLong(Date())))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
