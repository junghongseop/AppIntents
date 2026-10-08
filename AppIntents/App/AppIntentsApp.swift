//
//  AppIntentsApp.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import SwiftUI
import SwiftData

@main
struct AppIntentsApp: App {
    private let container: ModelContainer
    @State private var viewModel: TaskListViewModel
    
    init() {
        let container = try! ModelContainer(for: TaskItem.self)
        self.container = container
        
        let repository = SwiftDataTaskRepository(context: container.mainContext)
        let service = TaskService(repository: repository)
        _viewModel = State(initialValue: TaskListViewModel(service: service))
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView(viewModel: viewModel)
        }
        .modelContainer(container)
    }
}
