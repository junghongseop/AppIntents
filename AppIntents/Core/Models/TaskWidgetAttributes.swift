//
//  TaskWidgetAttributes.swift
//  AppIntents
//
//  Created by 정홍섭 on 10/10/26.
//

import Foundation
import ActivityKit

struct TaskWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
