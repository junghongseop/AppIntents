//
//  TaskListViewModel.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/8/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class TaskListViewModel {
    private let service: TaskService
    
    var tasks: [TaskItem] = []
    var errorMessage: String?
    
    init(service: TaskService) {
        self.service = service
    }
    
    func loadTasks() async {
        do {
            tasks = try await service.fetchTasks()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
