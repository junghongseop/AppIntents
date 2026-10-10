//
//  CompleteTaskIntent.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import AppIntents

struct CompleteTaskIntent: AppIntent {
    static let title: LocalizedStringResource = "할 일 완료"
    
    @Parameter(title: "할 일")
    var task: TaskEntity
    
    @Dependency private var service: TaskService
    
    static var parameterSummary: some ParameterSummary {
        Summary("\(\.$task) 완료")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        do {
            _ = try await service.completeTask(id: task.id)
            return .result(dialog: "할 일을 완료했어요.")
        } catch TaskServiceError.taskNotFound {
            throw AppIntentError(description: "할 일을 찾을 수 없어요.")
        }
    }
}
