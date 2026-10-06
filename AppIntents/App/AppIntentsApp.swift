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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
}
