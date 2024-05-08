//
//  ContentView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @State var email = ""
    @State var password = ""
    @State var login = ""
    @State var isRegistered = false
    @State private var isPasswordHidden = true
    @State private var showingAlert = false
    
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
                        Rectangle()
                            .frame(width: 224, height: 50)
                            .foregroundColor(isRegistrationEnabled ? Color("MainColor") : Color("InactiveColor").opacity(0.5))
                            .cornerRadius(16)
                            .overlay(
                                Text("Регистрация")
                                    .foregroundColor(.white)
                                    .font(.custom("AmericanTypewriter", size: 20))
                            )
                    }
                    .disabled(!isRegistrationEnabled)
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
        Task {
            do {
                try await AuthService.shared.registerWithEmail(email: email, password: password, isAdmin: false)
                appRootManager.currentRoot = .main
            } catch {
                print(error)
            }

        }
    }
}


#Preview {
    SignUpView()
}
