//
//  AuthServicre.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 04.05.2024.
//

import SwiftUI
import Firebase

final class AuthService {
    private let auth = Auth.auth()
    
    static let shared = AuthService()
    
    private init() {}
    
    func registerWithEmail(email: String, password: String) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        print("Registered: ", result)
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        print("Signed in: ", result)
    }
    
    func logOut() throws {
        try auth.signOut()
        print("Signed out")
    }
    
    
}
