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
    var body: some Scene {
        WindowGroup {
            SignUpView()
        }
    }
}
