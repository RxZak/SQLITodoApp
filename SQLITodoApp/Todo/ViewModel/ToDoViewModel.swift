//
//  ToDoViewModel.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import Foundation
import SwiftData

class ToDoViewModel: ObservableObject {
    
    // MARK: - Properties

    var viewModel: AuthViewModel
    var modelContext: ModelContext
    @Published var uncompletedItems: [ToDoItem] = [ToDoItem]()
    @Published var completedItems: [ToDoItem] = [ToDoItem]()
    
    // MARK: - Initializer

    init(modelContext: ModelContext, authViewModel: AuthViewModel) {
        self.viewModel = authViewModel
        self.modelContext = modelContext
        fetchData()
    }
    
    // MARK: - Fetch Data Function

    func fetchData() {
        do {
            let uncompletedDescriptor = FetchDescriptor<ToDoItem>(
                predicate: #Predicate { $0.isCompleted == false },
                sortBy: [SortDescriptor(\.timeStamp)])
            self.uncompletedItems = try modelContext.fetch(uncompletedDescriptor).filter { item in
                item.userUUID == viewModel.currentUser?.id
            }
            
            let completedDescriptor = FetchDescriptor<ToDoItem>(
                predicate: #Predicate { $0.isCompleted == true },
                sortBy: [SortDescriptor(\.timeStamp)])
            self.completedItems = try modelContext.fetch(completedDescriptor).filter { item in
                item.userUUID == viewModel.currentUser?.id
            }
            print("😀 completed \(self.completedItems)")
        } catch {
            print("😀 fetchdata \(error.localizedDescription)")
        }
    }
}

