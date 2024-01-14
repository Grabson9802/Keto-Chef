//
//  UserSettingsViewModel.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import Foundation

class UserSettingsViewModel: ObservableObject {
    @Published var authenticationViewModel: AuthenticationViewModel
    
    init(authenticationViewModel: AuthenticationViewModel) {
        self.authenticationViewModel = authenticationViewModel
    }
    
    func logOut() {
        authenticationViewModel.logout()
    }
}
