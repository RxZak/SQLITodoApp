//
//  ToDoListView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    // MARK: - Properties

    @Environment(\.modelContext) var context
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var toDoViewModel: ToDoViewModel
    @State private var showCreate: Bool = false
    @State private var toDoToEdit: ToDoItem?

    // MARK: - Body

    var body: some View {
        NavigationStack {
            List {
                // MARK: - Uncompleted Tasks Section

                Section("Uncompleted") {
                    ForEach(toDoViewModel.uncompletedItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                if item.isImportant {
                                    Image(systemName: "exclamationmark.3")
                                        .symbolVariant(.fill)
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Text(item.title)
                                    .font(.largeTitle)
                                    .bold()
                                
                                Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                    .font(.callout)
                            }
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    item.isCompleted.toggle()
                                    toDoViewModel.fetchData()
                                }
                            } label: {
                                
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                
                                withAnimation {
                                    context.delete(item)
                                    toDoViewModel.fetchData()
                                }
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                            }
                            
                            Button {
                                toDoToEdit = item
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                    }
                }
                
                // MARK: - Completed Tasks Section

                Section("Completed") {
                    ForEach(toDoViewModel.completedItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                if item.isImportant {
                                    Image(systemName: "exclamationmark.3")
                                        .symbolVariant(.fill)
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Text(item.title)
                                    .font(.largeTitle)
                                    .bold()
                                
                                Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                    .font(.callout)
                            }
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    item.isCompleted.toggle()
                                    toDoViewModel.fetchData()
                                }
                            } label: {
                                
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                
                                withAnimation {
                                    context.delete(item)
                                    toDoViewModel.fetchData()
                                }
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                            }
                            
                            Button {
                                toDoToEdit = item
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle("My To Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ProfileView()) {
                        Label("Profile", systemImage: "person")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showCreate.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreate,
                   content: {
                NavigationStack {
                    CreateToDoView(toDoViewModel: toDoViewModel)
                }
                .presentationDetents([.medium])
            })
            .sheet(item: $toDoToEdit) {
                toDoToEdit = nil
            } content: { item in
                UpdateToDoView(toDoViewModel: toDoViewModel, item: item)
            }
            .task {
                toDoViewModel.fetchData()
            }
        }
    }
}

