//
//  AuthenticationViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    enum AuthenticationState {
        case login, register, forgotPassword
    }
    
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
        } else {
            isLoggedIn = false
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
            isLoggedIn = false
            showAlert = false
            email = ""
            password = ""
        } catch {
            alertMessage = "Error: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            self.handleAuthenticationResult(with: error, successMessage: "Login successful")
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
            isLoggedIn = true
            selectedTabIndex = 2
        }
        showAlert = true
    }
}


