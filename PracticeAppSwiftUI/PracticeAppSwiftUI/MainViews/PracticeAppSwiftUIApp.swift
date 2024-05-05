//
//  PracticeAppSwiftUIApp.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct PracticeAppSwiftUIApp: App {
    @StateObject private var appRootManager = AppRootManager()
    
    init() {
        FirebaseApp.configure()
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
        }
    }
}
