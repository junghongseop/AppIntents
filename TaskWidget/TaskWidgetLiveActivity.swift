//
//  TaskWidgetLiveActivity.swift
//  TaskWidget
//
//  Created by 정홍섭 on 10/10/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TaskWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TaskWidgetAttributes.self) { context in
            VStack {
                Text(context.attributes.taskTitle)
                Text(context.state.emoji)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TaskWidgetAttributes {
    fileprivate static var preview: TaskWidgetAttributes {
        TaskWidgetAttributes(taskID: UUID(), taskTitle: "보고서 작성 ")
    }
}

extension TaskWidgetAttributes.ContentState {
    fileprivate static var smiley: TaskWidgetAttributes.ContentState {
        TaskWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TaskWidgetAttributes.ContentState {
         TaskWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TaskWidgetAttributes.preview) {
   TaskWidgetLiveActivity()
} contentStates: {
    TaskWidgetAttributes.ContentState.smiley
    TaskWidgetAttributes.ContentState.starEyes
}
