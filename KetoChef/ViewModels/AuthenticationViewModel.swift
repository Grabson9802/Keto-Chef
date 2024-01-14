//
//  AuthenticationViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isRegistering = false
    @Published var authenticationError: String?

    func authenticate() {
        if isRegistering {
            register()
        } else {
            login()
        }
    }

    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authenticationError = "Error registering user: \(error.localizedDescription)"
                } else {
                    // Registration successful
                    self.authenticationError = nil
                }
            }
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authenticationError = "Error logging in: \(error.localizedDescription)"
                } else {
                    // Login successful
                    self.authenticationError = nil
                }
            }
        }
    }
}

