//
//  User.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return "-"
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, name: "Zakariae ISMAILI", email: "zismaili@sqli.com")
}
