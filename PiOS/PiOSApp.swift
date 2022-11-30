//
//  PiOSApp.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-23.
//


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct PiOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var dbConnection = DatabaseConnection()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView( isSearching: .constant(.random()), isLoginIn: .constant(.random())).environmentObject(DatabaseConnection())
//            ContentView(isSearching: .constant(.random())).environmentObject(DatabaseConnection())
//                        ContentView(isSearching: .constant(.random()))
        
        }
    }
}

