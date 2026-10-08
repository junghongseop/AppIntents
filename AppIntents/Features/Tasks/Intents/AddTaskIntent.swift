//
//  AddTaskIntent.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/8/26.
//

import Foundation
import AppIntents

struct AddTaskIntent: AppIntent {
    static let title: LocalizedStringResource = "할 일 추가"
    static let description = IntentDescription("새 할 일을 저장합니다.")
    
    @Parameter(title: "할 일 제목")
    var taskTitle: String
    
    @Parameter(title: "마감일")
    var dueDate: Date?
    
    @Dependency
    private var service: TaskService
    
    static var parameterSummary: some ParameterSummary {
        Summary("할 일 \(\.$taskTitle) 추가") {
            \.$dueDate
        }
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        do {
            _ = try await service.addTask(title: taskTitle, dueDate: dueDate)
            return .result()
        } catch TaskServiceError.emptyTitle {
            throw AppIntentError(description: "할 일 제목을 입력해주세요.")
        }
    }
}
