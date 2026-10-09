//
//  TaskPriorityOption.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/9/26.
//

import Foundation
import AppIntents

enum TaskPriorityOption: String, AppEnum {
    case high
    case normal
    case low
    
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "중요도"
    
    static let caseDisplayRepresentations: [Self : DisplayRepresentation] = [
        .high: "높음",
        .normal: "보통",
        .low: "낮음"
    ]
}
