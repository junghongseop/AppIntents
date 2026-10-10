//
//  TaskWidgetBundle.swift
//  TaskWidget
//
//  Created by 정홍섭 on 10/10/26.
//

import WidgetKit
import SwiftUI

@main
struct TaskWidgetBundle: WidgetBundle {
    var body: some Widget {
        TaskWidget()
        TaskWidgetControl()
        TaskWidgetLiveActivity()
    }
}
