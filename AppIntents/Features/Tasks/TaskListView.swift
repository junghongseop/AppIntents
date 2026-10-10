//
//  TaskListView.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/8/26.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Bindable var viewModel: TaskListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("할 일 제목", text: $viewModel.newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("추가") {
                        Task {
                            await viewModel.addTask()
                        }
                    }
                }
                .padding(.horizontal)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                
                List(viewModel.tasks, id: \.id) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                        
                        if let dueDate = task.dueDate {
                            Text("마감일: \(dueDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text("중요도: \(task.priority.label)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(task.isCompleted ? "완료" : "진행 중")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("할 일")
            .task {
                await viewModel.loadTasks()
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    Task {
                        await viewModel.loadTasks()
                    }
                }
            }
        }
    }
}

private extension TaskPriority {
    var label: String {
        switch self {
        case .high: "높음"
        case .low: "낮음"
        case .normal: "보통"
        }
    }
}
