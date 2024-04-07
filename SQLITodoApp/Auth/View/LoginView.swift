//
//  LoginView.swift
//  SQLITodoApp
//
//  Created by Zakariae Ismaili on 2/4/2024.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties

    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
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
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your Password",
                              isSecureField: true)
                    
                    // MARK: - Remember Me Functionality

                    Toggle("Remember Me", isOn: $rememberMe)
                        .padding(.top, 8)

                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // MARK: - Persist User Credentials

                .onAppear {
                    if let savedEmail = UserDefaults.standard.string(forKey: "savedEmail") {
                        email = savedEmail
                    }
                    if let savedPassword = UserDefaults.standard.string(forKey: "savedPassword") {
                        password = savedPassword
                    }
                }
                .onChange(of: rememberMe, initial: viewModel.rememberMe) {
                    viewModel.saveUserCredentials(rememberMe: rememberMe, email: email, password: password)
                }
                
                // MARK: - Login Button

                Button{
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Login")
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
                
                // MARK: - Registration Navigation

                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Register")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color("SecondaryColor"))
                }
            }
        }
    }
}

// MARK: - Form Validation Protocol Impl

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.isEmpty
        && password.count >= 6
    }
}

#Preview {
    LoginView()
}
