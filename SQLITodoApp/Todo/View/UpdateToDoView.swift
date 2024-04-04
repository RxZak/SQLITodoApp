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
    var toDoViewModel: ToDoViewModel
    
    init(toDoViewModel: ToDoViewModel, item: ToDoItem) {
        self.toDoViewModel = toDoViewModel
        self.item = item
    }
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date",
                       selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isImportant)
            Button("Update") {
                toDoViewModel.fetchData()
                dismiss()
            }
        }
        .navigationTitle("Update Task")
    }
}
