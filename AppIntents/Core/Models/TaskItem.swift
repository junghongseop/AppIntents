//
//  TaskItem.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation
import SwiftData

@Model
final class TaskItem {
    var id: UUID
    var createdAt: Date
    var title: String
    var dueDate: Date?
    var priority: TaskPriority
    var isCompleted: Bool
    
    init(title: String, dueDate: Date? = nil, priority: TaskPriority = .normal) {
        self.id = UUID()
        self.createdAt = .now
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = false
    }
}

enum TaskPriority: Codable {
    case high
    case normal
    case low
}
