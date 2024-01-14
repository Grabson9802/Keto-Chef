//
//  AccountView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if viewModel.authenticationState != .forgotPassword {
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Button(action: {
                viewModel.authenticate()
            }) {
                Text(viewModel.authenticationState == .login ? "Login" : (viewModel.authenticationState == .forgotPassword ? "Send Reminder" : "Register"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                viewModel.authenticationState = viewModel.authenticationState == .login ? .register : .login
            }) {
                Text(viewModel.authenticationState == .login ? "Don't have an account? Register" : "Already have an account? Login")
                    .foregroundColor(.blue)
                    .padding(.top)
            }

            Button(action: {
                viewModel.authenticationState = .forgotPassword
            }) {
                Text("Forgot Password?")
                    .foregroundColor(.red)
                    .padding(.top)
            }

            Spacer()

            Button(action: {
                
            }) {
                Text("Unlock Premium Experience")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Authentication"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AuthenticationView(viewModel: AuthenticationViewModel())
}

