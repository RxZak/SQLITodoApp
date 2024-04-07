//
//  UpdateToDoView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    // MARK: - Properties

    @Environment(\.dismiss) var dismiss
    @Bindable var item: ToDoItem
    var toDoViewModel: ToDoViewModel
    
    // MARK: - Init

    init(toDoViewModel: ToDoViewModel, item: ToDoItem) {
        self.toDoViewModel = toDoViewModel
        self.item = item
    }
    
    // MARK: - Body
    
    var body: some View {
        List {
            
            // MARK: - Task Details Section

            TextField("Name", text: $item.title)
            DatePicker("Choose a date",
                       selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isImportant)
            
            // MARK: - Task Update Button

            Button("Update") {
                toDoViewModel.fetchData()
                dismiss()
            }
        }
        .navigationTitle("Update Task")
    }
}
