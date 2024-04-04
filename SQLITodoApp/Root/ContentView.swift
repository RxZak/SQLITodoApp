//
//  ContentView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ToDoListView(authViewModel: viewModel, modelContext: modelContext)
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
