//
//  OpenTaskIntent.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import AppIntents

struct OpenTaskIntent: OpenIntent, TargetContentProvidingIntent {
    static let title: LocalizedStringResource = "할 일 열기"
    
    @Parameter(title: "할 일", requestValueDialog: "어떤 할 일을 열까요?")
    var target: TaskEntity
}
