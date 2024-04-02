//
//  ProfileView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("ZI")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Zakariae ISMAILI")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("zismaili@sqli.com")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            
            Section("App Info") {
                
            }
            
            Section("Actions") {
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
