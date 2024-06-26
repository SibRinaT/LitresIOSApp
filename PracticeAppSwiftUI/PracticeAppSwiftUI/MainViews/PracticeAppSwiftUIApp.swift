//
//  PracticeAppSwiftUIApp.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct PracticeAppSwiftUIApp: App {
    @StateObject private var appRootManager = AppRootManager()
    @State private var authService: AuthService
    
    init() {
        #if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        #endif
        FirebaseApp.configure()
        
        authService = AuthService()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .signUp:
                    SignUpView()
                case .signIn:
                    LogInView()
                case .main:
                    MainView()
                }
            }
            .environmentObject(appRootManager)
            .environment(authService)
        }
    }
}
