//
//  TaskWidgetControl.swift
//  TaskWidget
//
//  Created by 정홍섭 on 10/10/26.
//

import AppIntents
import SwiftUI
import WidgetKit

struct TaskWidgetControl: ControlWidget {
    static let kind: String = "com.theo.AppIntents.CompleteTaskControl"

    var body: some ControlWidgetConfiguration {
        AppIntentControlConfiguration(
            kind: Self.kind,
            intent: TaskControlConfiguration.self
        ) { configuration in
            ControlWidgetButton(
                action: CompleteWidgetTaskIntent(taskID: configuration.task?.id)
            ) {
                Label(configuration.task?.title ?? "할 일 선택", systemImage: "checkmark.circle")
            }
        }
        .displayName("할 일 완료")
        .description("선택한 할 일을 완료합니다.")
        .promptsForUserConfiguration()
    }
}

struct TaskControlConfiguration: ControlConfigurationIntent {
    static let title: LocalizedStringResource = "완료할 할 일 선택"
    
    @Parameter(title: "할 일")
    var task: WidgetTaskEntity?
}
