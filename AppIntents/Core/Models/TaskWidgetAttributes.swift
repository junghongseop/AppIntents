//
//  TaskWidgetAttributes.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import ActivityKit

struct TaskWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var isCompleted: Bool
    }

    var taskID: UUID
    var taskTitle: String
}
