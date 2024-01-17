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
    @ObservedObject private var shoppingListViewModel = ShoppingListViewModel()
    @ObservedObject private var educationViewModel = EducationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationViewModel)
                .environmentObject(recipeViewModel)
                .environmentObject(shoppingListViewModel)
                .environmentObject(educationViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var recipeViewModel: RecipeViewModel
    @EnvironmentObject private var authenticationViewModel: AccountViewModel
    @EnvironmentObject private var shoppingListViewModel: ShoppingListViewModel
    @EnvironmentObject private var educationViewModel: EducationViewModel
    
    var body: some View {
        TabView(selection: $authenticationViewModel.selectedTabIndex)  {
            Group {
                RecipeView(viewModel: recipeViewModel, onFavoritesView: false)
                    .tabItem {
                        Label("Recipes", systemImage: "book")
                    }
                    .tag(0)
                
                ShoppingListView(viewModel: shoppingListViewModel)
                    .tabItem {
                        Label("Shopping List", systemImage: "cart.fill")
                    }
                    .tag(1)
                
                RecipeView(viewModel: recipeViewModel, onFavoritesView: true)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(2)
                
                EducationView(viewModel: educationViewModel)
                    .tabItem {
                        Label("Education", systemImage: "book.circle.fill")
                    }
                    .tag(3)
                
                AccountView(viewModel: authenticationViewModel)
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
                    .tag(4)
            }
            .onAppear {
                authenticationViewModel.checkUserLoggedIn()
            }
        }
    }
}
