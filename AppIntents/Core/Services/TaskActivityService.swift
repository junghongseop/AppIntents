//
//  TaskActivityService.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import ActivityKit

@MainActor
final class TaskActivityService {
    func start(for task: TaskItem) throws {
        guard !Activity<TaskWidgetAttributes>.activities.contains(where: {
            $0.attributes.taskID == task.id
        }) else {
            return
        }
        
        let attributes = TaskWidgetAttributes(taskID: task.id, taskTitle: task.title)
        let state = TaskWidgetAttributes.ContentState(isCompleted: task.isCompleted)
        let content = ActivityContent(state: state, staleDate: nil)
        
        _ = try Activity<TaskWidgetAttributes>.request(
            attributes: attributes,
            content: content,
            pushType: nil
        )
    }
}
