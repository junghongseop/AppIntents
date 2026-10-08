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
    var newTaskTitle = ""
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
    
    func addTask() async {
        do {
            let task =  try await service.addTask(title: newTaskTitle)
            tasks.append(task)
            newTaskTitle = ""
            errorMessage = nil
        } catch TaskServiceError.emptyTitle {
            errorMessage = "제목을 입력해 주세요."
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
