//
//  AuthViewModel.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var rememberMe: Bool
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.rememberMe = UserDefaults.standard.bool(forKey: "rememberMe")

        Task {
            await fetchUserData()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.userSession = result.user
            }
            if rememberMe {
                UserDefaults.standard.set(true, forKey: "rememberMe")
            } else {
                UserDefaults.standard.set(false, forKey: "rememberMe")
            }
            await fetchUserData()
        } catch {
            print("SIGN IN FAILED WITH ERROR: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.userSession = result.user
            }
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUserData()
        } catch {
            print("CREATE USER FAILED WITH ERROR: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession = nil
                self.currentUser = nil
            }
            if !rememberMe {
                UserDefaults.standard.removeObject(forKey: "savedEmail")
                UserDefaults.standard.removeObject(forKey: "savedPassword")
            }
        } catch {
            print("SIGN OUT FAILED WITH ERROR: \(error.localizedDescription)")
        }
    }
    
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        let currentUser = try? snapshot.data(as: User.self)
        DispatchQueue.main.async {
            self.currentUser = currentUser
        }

        print("😀 Current user is \(self.currentUser?.name ?? "No user")")
        print("😀 Current user id is \(self.currentUser?.id ?? "No id")")
        print("😀 session user uid is \(self.userSession?.uid ?? "No uid")")
    }
    
    func saveUserCredentials(rememberMe: Bool, email: String, password: String) {
        if rememberMe {
            UserDefaults.standard.set(email, forKey: "savedEmail")
            UserDefaults.standard.set(password, forKey: "savedPassword")
        } else {
            UserDefaults.standard.removeObject(forKey: "savedEmail")
            UserDefaults.standard.removeObject(forKey: "savedPassword")
        }
        self.rememberMe = rememberMe
        UserDefaults.standard.set(rememberMe, forKey: "rememberMe")
        print("😀 \(self.rememberMe)")
    }

}
