//
//  AuthServicre.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 04.05.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore


final class AuthService {
    private let auth = Auth.auth()
    let db = Firestore.firestore()
    private let userIdKey = "userIdKey"
    
    static let shared = AuthService()
    
    private init() {}
    
    func registerWithEmail(email: String, password: String, isAdmin: Bool) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        let userId = result.user.uid
        let user = User(id: userId, name: "", isAdmin: isAdmin, isSubscriptionEnabled: false)
        try db.collection("users").document(userId).setData(from: user)
        setLocalUser(id: userId)
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        setLocalUser(id: result.user.uid)
        print("Signed in: ", result)
    }
    
    func logOut() throws {
        try auth.signOut()
        UserDefaults.standard.removeObject(forKey: userIdKey)
        print("Signed out")
    }
    
    func fetchUserInfo() async throws -> User? {
        do {
            guard let userId = getUserId() else { return nil }
            let document = try await db.collection("users").document(userId).getDocument()
            return try document.data(as: User.self)
        } catch {
            print("Error getting documents: \(error)")
            return nil
        }
    }
    
    func enableSubscription() {
        
    }
    
    func setLocalUser(id: String) {
        UserDefaults.standard.set(id, forKey: userIdKey)
    }
    
    func getUserId() -> String? {
        UserDefaults.standard.string(forKey: userIdKey)
    }
}
