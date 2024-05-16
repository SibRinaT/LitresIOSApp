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
import Observation

@Observable
final class AuthService {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let userIdKey = "userIdKey"
    private let usersCollection = "users"

    var user: User?
        
    init() {
        Task {
            try? await fetchUserInfo()
        }
    }
    
    func registerWithEmail(email: String, name: String, password: String, isAdmin: Bool) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        let userId = result.user.uid
        let user = User(id: userId, name: name, isAdmin: isAdmin)
        try db.collection(usersCollection).document(userId).setData(from: user)
        setLocalUser(id: userId)
        try await fetchUserInfo()
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        setLocalUser(id: result.user.uid)
        try await fetchUserInfo()
    }
    
    func logOut() throws {
        UserDefaults.standard.removeObject(forKey: userIdKey)
        user = nil
        try auth.signOut()
        print("Signed out")
    }
    
    func fetchUserInfo() async throws {
        if user != nil { return }
        guard let userId = getUserId() else { return }
        let document = try await db.collection(usersCollection).document(userId).getDocument()
        let user = try document.data(as: User.self)
        self.user = user
    }
    
    func enableSubscription() async throws {
        if var user = self.user {
            if user.isSubscriptionEnabled {
                throw ApiError.custom(text: "subscription is already enabled.")
            }
            user.enableSubscription()
            let ref = db.collection(usersCollection).document(user.id)
            try await ref.updateData(user.asDictionary())
        } else {
            try await fetchUserInfo()
            try await enableSubscription()
        }
    }
    
    func setLocalUser(id: String) {
        UserDefaults.standard.set(id, forKey: userIdKey)
    }
    
    func getUserId() -> String? {
        UserDefaults.standard.string(forKey: userIdKey)
    }
}

struct AuthServiceKey: EnvironmentKey {
    static var defaultValue = AuthService()
}
