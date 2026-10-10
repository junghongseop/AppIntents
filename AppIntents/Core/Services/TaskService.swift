//
//  TaskService.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation
import WidgetKit

enum TaskServiceError: Error {
    case emptyTitle
    case taskNotFound
}

@MainActor
final class TaskService {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func addTask(title: String, dueDate: Date? = nil, priority: TaskPriority = .normal) async throws -> TaskItem {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else {
            throw TaskServiceError.emptyTitle
        }
        
        let task = TaskItem(title: title, dueDate: dueDate, priority: priority)
        try await repository.add(task)
        
        WidgetCenter.shared.reloadTimelines(ofKind: "TaskWidget")
        
        return task
    }
    
    func fetchTasks() async throws -> [TaskItem]{
        try await repository.fetchAll()
    }
    
    func completeTask(id: UUID) async throws -> TaskItem {
        guard let task = try await repository.fetch(id: id) else {
            throw TaskServiceError.taskNotFound
        }
        
        if !task.isCompleted {
            task.isCompleted = true
            try await repository.save()
        }
            
        return task
    }
}
