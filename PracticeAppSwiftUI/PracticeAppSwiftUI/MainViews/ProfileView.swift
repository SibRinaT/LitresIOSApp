//
//  ProfileView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        Button {
            logOut()
        } label: {
            Text("Выйти из аккаунта")
        }
    }
    
    private func logOut() {
        Task {
            try Auth.auth().signOut()
            appRootManager.currentRoot = .signUp
        }
    }
}

#Preview {
    ProfileView()
}
