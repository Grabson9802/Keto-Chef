//
//  UserSettingsView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct UserSettingsView: View {
    @ObservedObject var viewModel: UserSettingsViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Premium")) { Button {
                } label: {
                    Text("Buy Premium")
                        .foregroundColor(.black)
                }
                }
            }
            .navigationBarItems(trailing: Button {
                viewModel.logOut()
            } label: {
                Text("Log out")
                    .foregroundColor(.black)
            }
            )
        }
    }
}

#Preview {
    UserSettingsView(viewModel: UserSettingsViewModel(authenticationViewModel: AuthenticationViewModel()))
}
