//
//  ResetPasswordView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 15/01/2024.
//

import SwiftUI

struct PasswordResetView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var viewModel = PasswordResetViewModel()
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("Enter e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Reset Password") {
                viewModel.resetPassword(email: email) { result in
                    switch result {
                    case .success:
                        showAlert = true
                        alertMessage = "Password reset email sent. Check your inbox."
                    case .failure(let error):
                        showAlert = true
                        alertMessage = "Error resetting password: \(error.localizedDescription)"
                    }
                }
            }
            .padding()

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))  {
                    dismiss()
                }
            )
        }
    }
}


#Preview {
    PasswordResetView()
}
