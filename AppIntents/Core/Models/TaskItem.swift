//
//  TaskItem.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation

struct TaskItem: Identifiable, Codable {
    let id: UUID
    let createdAt: Date
    var title: String
    var dueDate: Date?
    var priority: TaskPriority
    var isCompleted: Bool
}

enum TaskPriority: Codable {
    case high
    case normal
    case low
}
