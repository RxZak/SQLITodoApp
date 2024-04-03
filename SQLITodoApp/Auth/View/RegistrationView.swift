//
//  RegistrationView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            Image("SQLI")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)

            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email",
                          placeholder: "name@sqli.com")
                .autocapitalization(.none)
                
                InputView(text: $name,
                          title: "Name",
                          placeholder: "John Doe")

                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your Password",
                          isSecureField: true)

                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Confirm Password",
                          isSecureField: true)

            }
            .padding(.horizontal)
            .padding(.top, 20)

            
            Button{
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, name: name)
                }
            } label: {
                HStack {
                    Text("Register")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color("SecondaryColor"))
            .cornerRadius(10)
            .padding(.top, 24)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
                
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(Color("SecondaryColor"))
            }

        }
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !name.isEmpty
        && !password.isEmpty
        && password.count >= 6
        && password == confirmPassword
    }
}


#Preview {
    RegistrationView()
}
