//
//  AppIntent.swift
//  TaskWidget
//
//  Created by 정홍섭 on 10/10/26.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "할 일 위젯 설정" }
    static var description: IntentDescription { "위젯에 표시할 할 일의 범위를 선택합니다." }
    
    @Parameter(title: "완료한 할 일 포함", default: true)
    var includesCompleted: Bool
}
