//
//  SwiftDataTaskRepository.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataTaskRepository: TaskRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAll() async throws -> [TaskItem] {
        try context.fetch(FetchDescriptor<TaskItem>())
    }
    
    func add(_ task: TaskItem) async throws {
        context.insert(task)
        try context.save()
    }
    
    func fetch(id: UUID) async throws -> TaskItem? {
        var descriptor = FetchDescriptor<TaskItem>(
            predicate: #Predicate<TaskItem> { $0.id == id }
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
    
    func save() async throws {
        try context.save()
    }
}
