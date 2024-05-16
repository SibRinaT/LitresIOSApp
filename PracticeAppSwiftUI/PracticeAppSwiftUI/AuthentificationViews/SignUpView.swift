//
//  ContentView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    @Environment(\.authService) var authService
    
    @State var email = ""
    @State var password = ""
    @State var login = ""
    @State var isRegistered = false
    @State private var isPasswordHidden = true
    @State private var showingLoading = false
    
    var isRegistrationEnabled: Bool {
        return !login.isEmpty && !password.isEmpty && !email.isEmpty
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackColor")
                    .ignoresSafeArea(.all)
                VStack {
                    Text("ДОБРО ПОЖАЛОВАТЬ")
                        .font(.custom("AmericanTypewriter", size: 32))
                    
                    Text("В МИР КНИГ")
                    
                    Text("РЕГИСТРАЦИЯ")
                        .font(.custom("AmericanTypewriter", size: 32))
                        .padding()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        InputFieldView(title: "Email", placeholder: "email123", text: $email)
                        InputFieldView(title: "Login", placeholder: "UserLogin", text: $login)
                        PasswordFieldView(title: "Password", placeholder: "bookQwe123", text: $password)
                    }
                    .padding(.bottom)
                    
                    VStack {
                        Button(action: {
                            appRootManager.currentRoot = .signIn
                        }) {
                            Text("Уже есть аккаунт?")
                                .foregroundColor(.white)
                            Text("Читайте в нём!")
                                .foregroundColor(Color("MainColor"))
                        }
                    }
                    .padding(10)
                    .font(.custom("AmericanTypewriter", size: 14))
                    .multilineTextAlignment(.center)
                    
                    Button(action: { signUpWithEmail()} ) {
                        if showingLoading {
                            Capsule()
                                .fill(isRegistrationEnabled ? Color("MainColor") : Color("InactiveColor").opacity(0.5))
                                .frame(width: 224, height: 50)
                                .overlay {
                                    ProgressView().progressViewStyle(.circular)
                                }
                        } else {
                            Capsule()
                                .fill(isRegistrationEnabled ? Color("MainColor") : Color("InactiveColor").opacity(0.5))
                                .frame(width: 224, height: 50)
                                .overlay {
                                    Text("Регистрация")
                                        .foregroundColor(.white)
                                        .font(.custom("AmericanTypewriter", size: 20))
                                }
                        }
                    }
                    .disabled(!isRegistrationEnabled || showingLoading)
                }
                .foregroundColor(Color("MainColor"))
                .font(.custom("AmericanTypewriter", size: 36))
                .multilineTextAlignment(.center)
            }
        }
        .sheet(isPresented: $isRegistered) {
            MainView()
        }
    }
    func signUpWithEmail() {
        showingLoading = true
        Task {
            do {
                try await authService.registerWithEmail(email: email, name: login, password: password, isAdmin: false)
                hideLoading()
                appRootManager.currentRoot = .main
            } catch {
                hideLoading()
                print(error)
            }
        }
    }
    
    private func hideLoading() {
        DispatchQueue.main.async {
            showingLoading = false
        }
    }
}


#Preview {
    SignUpView()
}
