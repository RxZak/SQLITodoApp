//
//  ToDoViewModel.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 4/4/2024.
//

import Foundation
import SwiftData

@Observable
class ToDoViewModel {
    
    var viewModel: AuthViewModel
    var modelContext: ModelContext
    var uncompletedItems: [ToDoItem] = [ToDoItem]()
    var completedItems: [ToDoItem] = [ToDoItem]()

    init(modelContext: ModelContext, authViewModel: AuthViewModel) {
        self.viewModel = authViewModel
        self.modelContext = modelContext
        fetchData()
    }

    func fetchData() {
        do {
            let uncompletedDescriptor = FetchDescriptor<ToDoItem>(
                predicate: #Predicate { $0.isCompleted == false },
                sortBy: [SortDescriptor(\.timeStamp)])
            uncompletedItems = try modelContext.fetch(uncompletedDescriptor).filter { item in
                item.userUUID == viewModel.currentUser?.id
            }

            let completedDescriptor = FetchDescriptor<ToDoItem>(
                predicate: #Predicate { $0.isCompleted == true },
                sortBy: [SortDescriptor(\.timeStamp)])
            completedItems = try modelContext.fetch(completedDescriptor).filter { item in
                item.userUUID == viewModel.currentUser?.id
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    

}
