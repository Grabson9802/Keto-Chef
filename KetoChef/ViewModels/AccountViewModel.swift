//
//  AuthenticationViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI
import FirebaseAuth

enum AuthenticationState {
    case login, register, forgotPassword
}

class AccountViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var authenticationState: AuthenticationState = .login
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var isLoggedIn = false
    @Published var selectedTabIndex: Int = 0
    
    func checkUserLoggedIn() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        }
    }
    
    func authenticate() {
        switch authenticationState {
        case .login:
            login()
        case .register:
            register()
        case .forgotPassword:
            sendPasswordResetEmail()
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            resetProperties()
            selectedTabIndex = 4
        } catch {
            alertMessage = "Error: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    private func resetProperties() {
        email = ""
        password = ""
        authenticationState = .login
        alertMessage = ""
        showAlert = false
        isLoggedIn = false
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            self.handleAuthenticationResult(with: error, successMessage: "Login successful")
            self.isLoggedIn = true
        }
    }
    
    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            self.handleAuthenticationResult(with: error, successMessage: "Registration successful. Verification email sent.")
            if error == nil {
                self.sendEmailVerification()
            }
        }
    }
    
    private func sendPasswordResetEmail() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            self.handleAuthenticationResult(with: error, successMessage: "Password reset email sent.")
        }
    }
    
    private func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            self.handleAuthenticationResult(with: error, successMessage: "Email verification sent.")
        })
    }
    
    private func handleAuthenticationResult(with error: Error?, successMessage: String) {
        if let error = error {
            alertMessage = "Error: \(error.localizedDescription)"
        } else {
            alertMessage = successMessage
        }
        showAlert = true
    }
}


