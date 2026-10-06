//
//  TaskRepository.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/7/26.
//

import Foundation

protocol TaskRepository {
    func fetchAll() async throws -> [TaskItem]
    func add(_ task: TaskItem) async throws
}
