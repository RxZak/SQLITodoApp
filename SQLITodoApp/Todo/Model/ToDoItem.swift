//
//  ToDoItem.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class ToDoItem {
    var title: String
    var timeStamp: Date
    var isImportant: Bool
    var isCompleted: Bool
    var userUUID: String
    
    init(title: String = "",
         timeStamp: Date = .now,
         isImportant: Bool = false,
         isCompleted: Bool = false,
         userUUID: String = "") {
        self.title = title
        self.timeStamp = timeStamp
        self.isImportant = isImportant
        self.isCompleted = isCompleted
        self.userUUID = userUUID
    }
}
