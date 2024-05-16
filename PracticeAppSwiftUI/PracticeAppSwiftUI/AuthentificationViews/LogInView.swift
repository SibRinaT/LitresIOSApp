//
//  LogInView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @Environment(\.authService) var authService
    @State private var email = ""
    @State private var password = ""
    
    var isLoginEnabled: Bool {
        return (!password.isEmpty && !email.isEmpty)
       }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackColor")
                    .ignoresSafeArea(.all)
                VStack {
                    Text("С ВОЗВРАЩЕНИЕМ")
                        .font(.custom("AmericanTypewriter", size: 32))
                    
                    Text("В МИР КНИГ")
                    
                    Text("ВХОД")
                        .font(.custom("AmericanTypewriter", size: 32))
                        .padding()
                        .padding(.bottom, 20)
                    
                    InputFieldView(title: "email", placeholder: "book@gmail.com", text: $email)
                    
                    PasswordFieldView(title: "пароль", placeholder: "book123", text: $password)
                        .padding(-20)
                        .font(.custom("AmericanTypewriter", size: 14))
                        .multilineTextAlignment(.center)

                    
                    VStack {
                        VStack {
                            Text("Забыли пароль?")
                                .foregroundColor(.white)
                            Text("Восстановите доступ!")
                                .foregroundColor(Color("MainColor"))
                        }
                        .padding(.bottom, 30)

                        Button(action: {
                            appRootManager.currentRoot = .signUp
                        }) {
                            VStack {
                                Text("У вас нет аккаунта?")
                                    .foregroundColor(.white)
                                Text("Начните чтение!")
                                    .foregroundColor(Color("MainColor"))
                            }
                        }
                    }
                    .padding(10)
                    .font(.custom("AmericanTypewriter", size: 14))
                    .multilineTextAlignment(.center)
                    
                    Button(action: {
                        signInWithEmail()
                    }) {
                        Rectangle()
                            .frame(width: 224, height: 50)
                            .cornerRadius(16)
                            .foregroundColor(isLoginEnabled ? Color("MainColor") : Color("InactiveColor").opacity(0.5))                            .overlay(
                                Text("Вход")
                                    .foregroundColor(.white)
                                    .font(.custom("AmericanTypewriter", size: 20))
                            )
                    }
                    .disabled(!isLoginEnabled)
                    
                }
                .foregroundColor(Color("MainColor"))
                .font(.custom("AmericanTypewriter", size: 36))
                .multilineTextAlignment(.center)
            }
        }
    }
    
    func signInWithEmail() {
        Task {
            do {
                try await authService.signInWithEmail(email: email, password: password)
                appRootManager.currentRoot = .main
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    LogInView()
}
