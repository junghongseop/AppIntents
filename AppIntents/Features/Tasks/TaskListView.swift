//
//  TaskListView.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/8/26.
//

import SwiftUI

struct TaskListView: View {
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
                    Text(task.title)
                }
            }
            .navigationTitle("할 일")
            .task {
                await viewModel.loadTasks()
            }
        }
    }
}
