//
//  ContentView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @State var email = ""
    @State var password = ""
    @State var login = ""
    @State var isRegistered = false
    @State private var isPasswordHidden = true

    @State private var showingAlert = false
    let titleEmail: String = "Email"
    let placeholderEmail: String = "book@gmail.com"
    let titlePassword: String = "Password"
    let placeholderPassword: String = "Qwe1234"
    let titleLogin: String = "Login"
    let placeholderLogin: String = "login"
    
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
                        Text(titleEmail)
                            .foregroundColor(Color(.white))
                            .font(.custom("AmericanTypewriter", size: 20))
                        ZStack {
                            Group {
                                Capsule()
                                    .stroke(Color(.white), lineWidth: 1) // black for test
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .frame(width: 302, height: 40)
                                TextField(placeholderEmail, text: $email)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(.black))
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .autocapitalization(.none)
                                    .frame(width: 302, height: 40)
                                    .foregroundColor(Color(.white))
                            }
                        }
                        .font(.caption2)
                        .textFieldStyle(.roundedBorder)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text(titleLogin)
                            .foregroundColor(Color(.white))
                            .font(.custom("AmericanTypewriter", size: 20))
                        ZStack {
                            Group {
                                Capsule()
                                    .stroke(Color(.white), lineWidth: 1) // black for test
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .frame(width: 302, height: 40)
                                TextField(placeholderLogin, text: $login)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(.black))
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .autocapitalization(.none)
                                    .frame(width: 302, height: 40)
                                    .foregroundColor(Color(.white))
                            }
                        }
                        .font(.caption2)
                        .textFieldStyle(.roundedBorder)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text(titlePassword)
                            .foregroundColor(Color(.white))
                            .font(.custom("AmericanTypewriter", size: 20))
                        ZStack(alignment: .trailing) {
                            Group {
                                Capsule()
                                    .stroke(Color(.white), lineWidth: 1) // black for test
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .frame(width: 302, height: 40)
                                Group {
                                    if isPasswordHidden {
                                        SecureField(placeholderPassword, text: $password)
                                    } else {
                                        TextField(placeholderPassword, text:  $password)
                                    }
                                }
                                .foregroundColor(Color(.black))
                                .font(.custom("AmericanTypewriter", size: 16))
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .textFieldStyle(PlainTextFieldStyle())
                                .frame(width: 302, height: 40)
                                .multilineTextAlignment(.leading)
                                
                            }
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(self.isPasswordHidden ? "eyeInactive" : "eyeActive")
                                    .accentColor(Color("MainColor"))
                            }
                            .padding(.trailing, 5)
                        }
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
                            .cornerRadius(16)
                            .foregroundColor(Color("MainColor"))
                            .overlay(
                                Text("Регистрация")
                                    .foregroundColor(.white)
                                    .font(.custom("AmericanTypewriter", size: 20))
                            )
                    }
                    //                    .disableWithOpacity()

                    //                        NavigationLink(destination: OTPVerificationView()) {
                    //                            Rectangle()
                    //                                .frame(width: 224, height: 50)
                    //                                .cornerRadius(16)
                    //                                .foregroundColor(Color("MainColor"))
                    //                                .overlay(
                    //                                    Text("Регистрация")
                    //                                        .foregroundColor(.white)
                    //                                        .font(.custom("AmericanTypewriter", size: 20))
                    //                                )
                    //                        }
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
                _ = try await Auth.auth().createUser(withEmail: email, password: password)
                appRootManager.currentRoot = .main
            } catch {
                print(error)
            }

        }
    }
    
//    func disableWithOpacity(_ condition: Bool ) -> some View  {
//        self
//            .disabled(condition)
//            .opacity(condition ? 0.6 : 1)
//    }
}


#Preview {
    SignUpView()
}
