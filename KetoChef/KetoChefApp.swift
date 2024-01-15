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
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return true
    }
}

@main
struct KetoChefApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var recipeViewModel = RecipeViewModel(recipeService: RecipeAPIService.shared)
    @ObservedObject private var authenticationViewModel = AccountViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationViewModel)
                .environmentObject(recipeViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var recipeViewModel: RecipeViewModel
    @EnvironmentObject private var authenticationViewModel: AccountViewModel
    
    var body: some View {
        TabView(selection: $authenticationViewModel.selectedTabIndex)  {
            Group {
                RecipeView(viewModel: recipeViewModel)
                    .tabItem {
                        Label("Recipes", systemImage: "book")
                    }
                    .tag(0)
                
                FavoritesView(viewModel: recipeViewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(1)
                
                AccountView(viewModel: authenticationViewModel)
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
                    .tag(2)
            }
            .onAppear {
                authenticationViewModel.checkUserLoggedIn()
            }
        }
    }
}
