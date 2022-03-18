//
//  SmallWIdget.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/12/22.
//

import Foundation
import WidgetKit
import SwiftUI

//@main
struct SmallWidget: Widget {
    let kind: String = "SmallWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SmallWidgetTimeline()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Small Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: SmallWidgetEntry(
            date: Date(),
            nextWorkoutName: "Full Body A",
            nextWorkoutDate: getDateAsStringLong(Date()) + ",\n" + getMonthAndDateAsString(Date())
        ))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
