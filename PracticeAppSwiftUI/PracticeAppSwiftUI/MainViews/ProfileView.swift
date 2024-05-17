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
    @Environment(\.authService) var authService
    @State private var presentAdminView = false
        @State private var sub =  "Базовая"

//    @State private var sub = Auth.auth().currentUser.subscription  ?? "Базовая"
    @State private var userEmail = Auth.auth().currentUser?.email ?? "no email"
    
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                Text("Профиль")
                    .font(.custom("AmericanTypewriter", size: 48))
                    .foregroundColor(.white)
                
                VStack {
                    Rectangle()
                        .frame(width: 280, height: 57)
                        .cornerRadius(14)
                        .foregroundColor(Color("SecondaryColor"))
                        .overlay(
                            HStack {
                                Text("Логин - ")
                                    .foregroundColor(.white)
                                Text(authService.user?.name ?? "No name")
                                    .foregroundColor(.white)
                            }
                        )
                    Rectangle()
                        .frame(width: 280, height: 57)
                        .cornerRadius(14)
                        .foregroundColor(Color("SecondaryColor"))
                        .overlay(
                            HStack {
                                Text("Почта - ")
                                    .foregroundColor(.white)
                                Text(userEmail)
                                    .foregroundColor(.white)
                            }
                        )
                    Rectangle()
                        .frame(width: 280, height: 57)
                        .cornerRadius(14)
                        .foregroundColor(Color("SecondaryColor"))
                        .overlay(
                            HStack {
                                Text("Подписка - ")
                                    .foregroundColor(.white)
                                Text(sub)
                                    .foregroundColor(.white)
                            }
                        )
                    
                    if let user = authService.user, user.isAdmin {
                        Button {
                            presentAdminView = true
                        } label: {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("SecondaryColor"))
                                .overlay(
                                    HStack {
                                        Text("Роль - Admin")
                                            .foregroundColor(.white)
                                    }
                                )
                        }
                    }
                    
                }
                .font(.custom("AmericanTypewriter", size: 16))
                
                Spacer()
                
                Button {
                    logOut()
                } label: {
                    Rectangle()
                        .frame(width: 200, height: 40)
                        .foregroundColor(Color("SecondaryColor"))
                        .cornerRadius(14)
                        .overlay(
                            Text("Выйти из аккаунта")
                                .font(.custom("AmericanTypewriter", size: 16))
                                .foregroundColor(Color("MainColor"))
                        )
                }
            }
            .popover(isPresented: $presentAdminView) {
                AdminOptionViews(isSheetPresented: $presentAdminView)
            }
        }
    }
    
    private func logOut() {
        Task {
            try authService.logOut()
            appRootManager.currentRoot = .signUp
        }
    }
}
