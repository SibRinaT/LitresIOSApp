//
//  PracticeAppSwiftUIApp.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI
import Firebase

@main
struct PracticeAppSwiftUIApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if logStatus {
                MainView()
            }else{
                LogInView()
            }
        }
    }
}
