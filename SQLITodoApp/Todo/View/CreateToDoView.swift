//
//  CreateToDoView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI

struct CreateToDoView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var item = ToDoItem()
    var toDoViewModel: ToDoViewModel
    
    init(toDoViewModel: ToDoViewModel) {
        self.toDoViewModel = toDoViewModel
    }

    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a Date", selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isImportant)
            Button("Create Task") {
                item.userUUID = viewModel.currentUser?.id ?? ""
                withAnimation {
                    context.insert(item)
                    toDoViewModel.fetchData()
                }
                dismiss()
            }
        }
        .navigationTitle("Create Task")
    }
}
