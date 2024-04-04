//
//  UpdateToDoView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var item: ToDoItem
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date",
                       selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isImportant)
            Button("Update") {
                dismiss()
            }
        }
        .navigationTitle("Update Task")
    }
}
