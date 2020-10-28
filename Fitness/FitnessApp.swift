//
//  FitnessApp.swift
//  Fitness
//
//  Created by Harsh on 19/09/20.
//

import SwiftUI
import Firebase

@main
struct FitnessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabViewContainer()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }else {
                LandingPage()
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Triggering")
        FirebaseApp.configure()
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    private let userService: UserServiceProtocol
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        //try? Auth.auth().signOut()
        userService.observeAuthChanges().map{$0 != nil}.assign(to: &$isLoggedIn)
    }
}
