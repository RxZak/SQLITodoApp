//
//  AuthViewModel.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("Signing in")
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        print("Creating user")

    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }

    func fetchUserData() async {
        
    }


}
