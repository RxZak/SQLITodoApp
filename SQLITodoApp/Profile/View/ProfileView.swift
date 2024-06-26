//
//  ProfileView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties

    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: - Body

    var body: some View {
        if let user = viewModel.currentUser {
            List {
                
                // MARK: - User Information Section

                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }
                }
                               
                // MARK: - Actions Section

                Section("Actions") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                }
            }

        }
    }
}
