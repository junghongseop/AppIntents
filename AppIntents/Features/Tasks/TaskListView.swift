//
//  TaskListView.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/8/26.
//

import SwiftUI

struct TaskListView: View {
    let viewModel: TaskListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.tasks, id: \.id) { task in
                Text(task.title)
            }
            .navigationTitle("할 일")
            .task {
                await viewModel.loadTasks()
            }
        }
    }
}
