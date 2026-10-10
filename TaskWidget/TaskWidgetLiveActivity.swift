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
                Text(context.state.isCompleted ? "완료" : "진행 중")
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("할 일")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.isCompleted ? "완료" : "진행 중")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.taskTitle)
                }
            } compactLeading: {
                Text("할 일")
            } compactTrailing: {
                Text(context.state.isCompleted ? "✓" : "진행")
            } minimal: {
                Text(context.state.isCompleted ? "✓" : "●")
            }
        }
    }
}

extension TaskWidgetAttributes {
    fileprivate static var preview: TaskWidgetAttributes {
        TaskWidgetAttributes(taskID: UUID(), taskTitle: "보고서 작성 ")
    }
}

extension TaskWidgetAttributes.ContentState {
    fileprivate static var inProgress: TaskWidgetAttributes.ContentState {
        TaskWidgetAttributes.ContentState(isCompleted: false)
     }
     
     fileprivate static var completed: TaskWidgetAttributes.ContentState {
         TaskWidgetAttributes.ContentState(isCompleted: true)
     }
}

#Preview("Notification", as: .content, using: TaskWidgetAttributes.preview) {
   TaskWidgetLiveActivity()
} contentStates: {
    TaskWidgetAttributes.ContentState.inProgress
    TaskWidgetAttributes.ContentState.completed
}
