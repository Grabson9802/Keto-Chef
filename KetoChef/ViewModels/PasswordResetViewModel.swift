//
//  PasswordResetViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 15/01/2024.
//

import FirebaseAuth

class PasswordResetViewModel: ObservableObject {
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
