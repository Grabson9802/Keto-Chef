//
//  AccountView.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 14/01/2024.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            if viewModel.isLoggedIn {
                Form {
                    Section(header: Text("Premium")) { Button {
                    } label: {
                        Text("Buy Premium")
                            .foregroundColor(.black)
                    }
                    }
                    
                    Section(header: Text("Account")) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Text("Change Password")
                                .foregroundColor(.black)
                                .sheet(isPresented: $isPresented) {
                                    PasswordResetView()
                                }
                        }
                    }
                }
                .navigationBarItems(trailing: Button {
                    viewModel.logout()
                } label: {
                    Text("Log out")
                        .foregroundColor(.black)
                }
                )
                .navigationTitle("Settings")
            } else {
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if viewModel.authenticationState != .forgotPassword {
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    Button {
                        viewModel.authenticate()
                    } label: {
                        Text(viewModel.authenticationState == .login ? "Login" : (viewModel.authenticationState == .forgotPassword ? "Send Reminder" : "Register"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button {
                        viewModel.authenticationState = viewModel.authenticationState == .login ? .register : .login
                    } label: {
                        Text(viewModel.authenticationState == .login ? "Don't have an account? Register" : "Already have an account? Login")
                            .foregroundColor(.blue)
                            .padding(.top)
                    }
                    
                    Button {
                        viewModel.authenticationState = .forgotPassword
                    } label: {
                        Text("Forgot Password?")
                            .foregroundColor(.red)
                            .padding(.top)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
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
                .navigationTitle("Authentication")
            }
        }
    }
}
