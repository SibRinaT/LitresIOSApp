//
//  ProfileView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @State private var presentAdminView = false
    
    var body: some View {
        VStack {
            Button {
                logOut()
            } label: {
                Text("Выйти из аккаунта")
            }
            Spacer()
            Button("Show Admin Panel") {
                presentAdminView = true
            }
        }
        .popover(isPresented: $presentAdminView) {
            AdminOptionViews(isSheetPresented: $presentAdminView)
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
