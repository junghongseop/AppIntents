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
    private let activityService = TaskActivityService()
    
    var tasks: [TaskItem] = []
    var newTaskTitle = ""
    var errorMessage: String?
    
    init(service: TaskService) {
        self.service = service
    }
    
    func loadTasks() async {
        do {
            let fetchedTasks = try await service.fetchTasks()
            tasks = fetchedTasks
            await service.indexTasks(fetchedTasks)
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
    
    func startActivity(for task: TaskItem) {
        do {
            try activityService.start(for: task)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
