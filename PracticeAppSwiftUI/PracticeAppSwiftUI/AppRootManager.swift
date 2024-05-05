//
//  AppRootManager.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import Foundation
import FirebaseAuth

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: appRoots = .signUp
    
    init() {
        if Auth.auth().currentUser == nil {
            currentRoot = .signUp
        } else {
            currentRoot = .main
        }
    }
    
    enum appRoots {
        case signUp
        case signIn
        case main
    }
}
