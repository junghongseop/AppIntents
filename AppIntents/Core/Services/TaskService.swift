//
//  TaskService.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation

enum TaskServiceError: Error {
    case emptyTitle
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
        return task
    }
    
    func fetchTasks() async throws -> [TaskItem]{
        try await repository.fetchAll()
    }
}
