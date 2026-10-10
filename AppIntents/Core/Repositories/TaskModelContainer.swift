//
//  TaskModelContainer.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import SwiftData

enum TaskModelContainer {
    static func make() throws -> ModelContainer {
        let schema = Schema([TaskItem.self])
        let configuration = ModelConfiguration(
            schema: schema,
            groupContainer: .identifier("group.com.theo.AppIntents")
        )
        
        return try ModelContainer(for: schema, configurations: [configuration])
    }
}
