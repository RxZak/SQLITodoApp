//
//  CreateToDoView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI

struct CreateToDoView: View {
    
    // MARK: - Properties

    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var item = ToDoItem()
    var toDoViewModel: ToDoViewModel
    
    // MARK: - Init

    init(toDoViewModel: ToDoViewModel) {
        self.toDoViewModel = toDoViewModel
    }
    
    // MARK: - Body

    var body: some View {
        List {
            
            // MARK: - Task Details Section

            TextField("Name", text: $item.title)
            DatePicker("Choose a Date", selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isImportant)
            
            // MARK: - Create Task Button

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
