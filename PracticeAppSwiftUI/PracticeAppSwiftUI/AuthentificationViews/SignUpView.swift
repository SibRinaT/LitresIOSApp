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
    @Environment(\.dismiss) private var dismiss

    @State private var error: UploadError?
    @State var email = ""
    @State var password = ""
    @State var login = ""
    @State private var isPasswordHidden = true
    @State private var showingLoading = false
    @State private var isShowingSuccess = false
    @State private var isShowingError = false


    
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
                                .fill(isRegistrationEnabled ? Color("InactiveColor") : Color("MainColor").opacity(0.5))
                                .frame(width: 224, height: 50)
                                .overlay {
                                    ProgressView().progressViewStyle(.circular)
                                }
                        } else {
                            Capsule()
                                .fill(isRegistrationEnabled ? Color("InactiveColor") : Color("MainColor").opacity(0.5))
                                .frame(width: 224, height: 50)
                                .overlay {
                                    Text("Регистрация")
                                        .foregroundColor(.white)
                                        .font(.custom("AmericanTypewriter", size: 20))
                                }
                        }
                    }
                    .alert(isPresented: $isShowingError, error: error) { _ in
                    } message: { error in
                        Text(error.errorDescription ?? "")
                    }
                    .alert("Успешно!", isPresented: $isShowingSuccess) {
                        Button("Ok") {
                            dismiss()
                        }
                    } message: {
                        Text("Регистрация прошла успешно!")
                    }
                    .disabled(!isRegistrationEnabled || showingLoading)
                }
                .foregroundColor(Color("MainColor"))
                .font(.custom("AmericanTypewriter", size: 36))
                .multilineTextAlignment(.center)
            }
        }
    }
    func signUpWithEmail() {
        showingLoading = true
        Task {
            do {
                try await authService.registerWithEmail(email: email, name: login, password: password, isAdmin: false)
                appRootManager.currentRoot = .main
                hideLoading()
            } catch {
                print(error)
                hideLoading()
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
