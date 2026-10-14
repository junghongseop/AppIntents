//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by 정홍섭 on 10/10/26.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            configuration: ConfigurationAppIntent(),
            taskCount: 0,
            task: nil
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            configuration: configuration,
            taskCount: 0,
            task: nil
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let widgetData = await fetchWidgetData(configuration: configuration)
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                configuration: configuration,
                taskCount: widgetData.count,
                task: widgetData.task
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
    
    @MainActor
    private func fetchWidgetData(configuration: ConfigurationAppIntent) -> (count: Int, task: WidgetTaskSnapshot?) {
        do {
            let container = try TaskModelContainer.make()
            let tasks = try container.mainContext.fetch(FetchDescriptor<TaskItem>())
            let remaining = tasks.filter { !$0.isCompleted }
            
            let chosen: TaskItem?
            
            if let selectedID = configuration.selectedTask?.id {
                chosen = remaining.first { $0.id == selectedID }
            } else {
                chosen = remaining.min { $0.createdAt < $1.createdAt }
            }
            
            let count = configuration.includesCompleted ? tasks.count : remaining.count
            let snapshot = chosen.map {
                WidgetTaskSnapshot(id: $0.id, title: $0.title)
            }
            
            return (count, snapshot)
        } catch {
            print("할 일 조회 실패: \(error)")
            return (0, nil)
        }
    }
}

struct WidgetTaskSnapshot: Sendable {
    let id: UUID
    let title: String
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let taskCount: Int
    let task: WidgetTaskSnapshot?
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.configuration.includesCompleted ? "전체 할 일" : "남은 할 일")
                .font(.caption)
            
            Text("\(entry.taskCount)개")
                .font(.largeTitle.bold())
            
            if let task = entry.task {
                HStack(spacing: 8) {
                    Text(task.title)
                        .font(.caption)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(intent: CompleteTaskInteractionIntent(taskID: task.id)) {
                        Image(systemName: "checkmark.circle")
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("할 일 완료")
                }
            } else {
                Text(entry.configuration.selectedTask == nil ? "미완료 할 일 없음" : "선택한 할 일 없음")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    TaskWidget()
} timeline: {
    SimpleEntry(
        date: .now,
        configuration: ConfigurationAppIntent(),
        taskCount: 0,
        task: nil
    )
}
