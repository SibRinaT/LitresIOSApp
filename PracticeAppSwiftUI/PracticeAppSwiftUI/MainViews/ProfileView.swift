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
    @State private var login: String = "SibRinaT"
    @State private var email: String = "sibrinat616@gmail.com"
    @State private var sub: String = "Базовая"
    @State private var Role: String = "Админ"

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
                                Text(login)
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
                                Text(email)
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
                    Rectangle()
                        .frame(width: 280, height: 57)
                        .cornerRadius(14)
                        .foregroundColor(Color("SecondaryColor"))
                        .overlay(
                            HStack {
                                Text("Роль - ")
                                    .foregroundColor(.white)
                                Text(Role)
                                    .foregroundColor(.white)
                            }
                        )
                }
                .font(.custom("AmericanTypewriter", size: 16))

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
                Spacer()
                Button("Show Admin Panel") {
                    presentAdminView = true
                }
                .foregroundColor(.white)
            }
            .popover(isPresented: $presentAdminView) {
                AdminOptionViews(isSheetPresented: $presentAdminView)
            }
            .onAppear {
                getUser()
            }
        }
    }
    
    private func getUser() {
        Task {
            do {
                let user = try? await AuthService.shared.fetchUserInfo()
                print(user)
            } catch {
                
            }
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
