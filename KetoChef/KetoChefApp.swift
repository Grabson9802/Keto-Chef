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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeView(viewModel: RecipeViewModel(recipeService: RecipeAPIService()))
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            FavoritesView(viewModel: FavoritesViewModel())
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            AuthenticationView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}
