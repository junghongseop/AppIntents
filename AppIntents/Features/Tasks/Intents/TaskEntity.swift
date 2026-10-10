//
//  TaskEntity.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/9/26.
//

import Foundation
import AppIntents

struct TaskEntity: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "할 일"
    static let defaultQuery = TaskEntityQuery()
    
    let id: UUID
    @Property(title: "제목") var title: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
    
    init(task: TaskItem) {
        self.id = task.id
        self.title = task.title
    }
}

struct TaskEntityQuery: EntityStringQuery {
    @Dependency private var service: TaskService
    
    @MainActor
    func entities(for identifiers: [Entity.ID]) async throws -> [TaskEntity] {
        let tasks = try await service.fetchTasks()
        
        return tasks
            .filter { identifiers.contains($0.id) }
            .map(TaskEntity.init)
    }
    
    @MainActor
    func entities(matching string: String) async throws -> [TaskEntity] {
        let tasks = try await service.fetchTasks()
        
        return tasks
            .filter { $0.title.localizedCaseInsensitiveContains(string) }
            .map(TaskEntity.init)
    }
    
    @MainActor
    func suggestedEntities() async throws -> [TaskEntity] {
        try await service.fetchTasks().map(TaskEntity.init)
    }
}
