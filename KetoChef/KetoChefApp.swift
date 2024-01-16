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
    @ObservedObject private var recipeViewModel = RecipeViewModel(recipeService: RecipeMockService.shared)
    @ObservedObject private var authenticationViewModel = AccountViewModel()
    @ObservedObject private var shoppingListViewModel = ShoppingListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationViewModel)
                .environmentObject(recipeViewModel)
                .environmentObject(shoppingListViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var recipeViewModel: RecipeViewModel
    @EnvironmentObject private var authenticationViewModel: AccountViewModel
    @EnvironmentObject private var shoppingListViewModel: ShoppingListViewModel
    
    var body: some View {
        TabView(selection: $authenticationViewModel.selectedTabIndex)  {
            Group {
                RecipeView(viewModel: recipeViewModel)
                    .tabItem {
                        Label("Recipes", systemImage: "book")
                    }
                    .tag(0)
                
                ShoppingListView(viewModel: shoppingListViewModel)
                    .tabItem {
                        Label("Shopping List", systemImage: "cart.fill")
                    }
                    .tag(1)
                
                FavoritesView(viewModel: recipeViewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(2)
                
                AccountView(viewModel: authenticationViewModel)
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
                    .tag(3)
            }
            .onAppear {
                authenticationViewModel.checkUserLoggedIn()
            }
        }
    }
}
