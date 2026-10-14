//
//  WidgetTaskEntity.swift
//  TaskWidgetExtension
//
//  Created by 정홍섭 on 10/14/26.
//

import Foundation
import AppIntents
import SwiftData

struct WidgetTaskEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "할 일"
    static var defaultQuery = WidgetTaskQuery()
    
    let id: UUID
    let title: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
    
    init(task: TaskItem) {
        id = task.id
        title = task.title
    }
}

struct WidgetTaskQuery: EntityQuery {
    @MainActor
    func entities(for identifiers: [WidgetTaskEntity.ID]) async throws -> [WidgetTaskEntity] {
        try fetchEntities(onlyIncomplete: false)
            .filter { identifiers.contains($0.id) }
    }
    
    @MainActor
    func suggestedEntities() async throws -> [WidgetTaskEntity] {
        try fetchEntities(onlyIncomplete: true)
    }
    
    @MainActor
    private func fetchEntities(onlyIncomplete: Bool) throws -> [WidgetTaskEntity] {
        let container = try TaskModelContainer.make()
        let tasks = try container.mainContext.fetch(FetchDescriptor<TaskItem>())
        
        return tasks
            .filter { !onlyIncomplete || !$0.isCompleted }
            .map(WidgetTaskEntity.init)
    }
    
    @MainActor
    func defaultResult() async -> WidgetTaskEntity? {
        let entities = try? fetchEntities(onlyIncomplete: true)
        return entities?.first
    }
}
