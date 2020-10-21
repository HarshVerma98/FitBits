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
    
    var body: some Scene {
        WindowGroup {
            LandingPage()
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
