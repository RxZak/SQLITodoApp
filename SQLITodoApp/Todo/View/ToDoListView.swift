//
//  ToDoListView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var showCreate: Bool = false
    @State private var toDoToEdit: ToDoItem?
    @Query(
        filter: #Predicate { (item: ToDoItem) in item.isCompleted == false },
        sort: \.timeStamp,
        order: .reverse
    ) private var uncompletedItems: [ToDoItem]
    
    @Query(
        filter: #Predicate { (item: ToDoItem) in item.isCompleted == true },
        sort: \.timeStamp,
        order: .reverse
    ) private var completedItems: [ToDoItem]

    var body: some View {
        NavigationStack {
            List {
                Section("Uncompleted") {
                    ForEach(uncompletedItems) { item in
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
                
                Section("Completed") {
                    ForEach(completedItems) { item in
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
                    CreateToDoView()
                }
                .presentationDetents([.medium])
            })
            .sheet(item: $toDoToEdit) {
                toDoToEdit = nil
            } content: { item in
                UpdateToDoView(item: item)
            }
        }
    }
}

