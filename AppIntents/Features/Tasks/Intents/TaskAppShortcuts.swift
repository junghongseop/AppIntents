//
//  TaskAppShortcuts.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import AppIntents

struct TaskAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddTaskIntent(),
            phrases: [
                "\(.applicationName)에서 할 일 추가"
            ],
            shortTitle: "할 일 추가",
            systemImageName: "plus.circle"
        )
    }
}
