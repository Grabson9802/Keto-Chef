//
//  KetoChefApp.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct KetoChefApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationViewModel)
                .onAppear {
                    authenticationViewModel.checkUserLoggedIn()
                }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            if authenticationViewModel.isLoggedIn {
                LoggedInView(authenticationViewModel: authenticationViewModel)
            } else {
                LoggedOutView(authenticationViewModel: authenticationViewModel)
            }
        }
        .onAppear {
            authenticationViewModel.checkUserLoggedIn()
        }
    }
}

struct LoggedInView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        TabView(selection: $authenticationViewModel.selectedTabIndex)  {
            RecipeView(viewModel: RecipeViewModel(recipeService: RecipeAPIService()))
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
                .tag(0)
            
            FavoritesView(viewModel: FavoritesViewModel())
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(1)
            
            UserSettingsView(viewModel: UserSettingsViewModel(authenticationViewModel: authenticationViewModel))
                .tabItem {
                    Label("Account", systemImage: "person")
                }
                .tag(2)
        }
    }
}

struct LoggedOutView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        TabView(selection: $authenticationViewModel.selectedTabIndex) {
            RecipeView(viewModel: RecipeViewModel(recipeService: RecipeAPIService()))
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
                .tag(0)
            
            FavoritesView(viewModel: FavoritesViewModel())
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(1)
            
            AuthenticationView(viewModel: authenticationViewModel)
                .tabItem {
                    Label("Account", systemImage: "person")
                }
                .tag(2)
        }
    }
}
