//
//  AccountView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.authenticate()
            }) {
                Text(viewModel.isRegistering ? "Register" : "Login")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            
            Button(action: {
                viewModel.isRegistering.toggle()
            }) {
                Text(viewModel.isRegistering ? "Already have an account? Login" : "Don't have an account? Register")
                    .foregroundColor(.blue)
                    .padding(.top)
            }
            
            if let error = viewModel.authenticationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}
