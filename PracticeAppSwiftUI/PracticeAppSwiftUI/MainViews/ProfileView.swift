//
//  ProfileView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import SwiftUI

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
            try AuthService.shared.logOut()
            appRootManager.currentRoot = .signUp
        }
    }
}

#Preview {
    ProfileView()
}
