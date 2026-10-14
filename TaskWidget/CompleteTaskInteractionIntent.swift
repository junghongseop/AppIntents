//
//  CompleteTaskInteractionIntent.swift
//  TaskWidgetExtension
//
//  Created by 정홍섭 on 10/14/26.
//

import Foundation
import AppIntents

struct CompleteTaskInteractionIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "할 일 완료"
    static var isDiscoverable: Bool = false
    
    @Parameter(title: "할 일 ID")
    var taskID: String?
    
    init() {}
    
    init(taskID: UUID?) {
        self.taskID = taskID?.uuidString
    }
    
    @Dependency private var action: TaskCompletionAction
    
    func perform() async throws -> some IntentResult {
        guard let taskID, let id = UUID(uuidString: taskID) else {
            throw AppIntentError(description: "할 일 ID가 올바르지 않아요.")
        }
        
        try await action.complete(id)
        return .result()
    }
}

struct TaskCompletionAction: Sendable {
    let complete: @Sendable (UUID) async throws -> Void
}
