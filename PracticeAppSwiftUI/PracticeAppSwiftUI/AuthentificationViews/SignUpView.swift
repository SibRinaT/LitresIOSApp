//
//  ContentView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var isRegistered = false
    @State private var isPasswordHidden = true

    let titleEmail: String = "Email"
    let placeholderEmail: String = "book@gmail.com"
    let titlePassword: String = "Password"
    let placeholderPassword: String = "Qwe1234"

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
                        
                        InputFieldView(title: "логин", placeholder: "user", text: "")
                            .padding(-20)
                        
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
                                    if isPasswordHidden {
                                        SecureField(placeholderPassword, text: $password)
                                            .foregroundColor(Color(.black))
                                            .font(.custom("AmericanTypewriter", size: 16))
                                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .frame(width: 302, height: 40)
                                            .multilineTextAlignment(.leading)
                                    } else {
                                        TextField(placeholderPassword, text:  $password)
                                            .foregroundColor(Color(.black))
                                            .font(.custom("AmericanTypewriter", size: 16))
                                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .frame(width: 302, height: 40)
                                            .multilineTextAlignment(.leading)
                                    }
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
                        
                        PasswordFieldView(title: "повторите пароль", placeholder: "book123", text: "")
                            .padding(-20)
                        
                        VStack {
                            Text("Уже есть аккаунт?")
                                .foregroundColor(.white)
                            NavigationLink(destination: LogInView()) {
                                Text("Читайте в нём!")
                                    .foregroundColor(Color("MainColor"))
                            }
                        }
                        .padding(3)
                        
                        .font(.custom("AmericanTypewriter", size: 14))
                        .multilineTextAlignment(.center)
                        
                        
                        NavigationLink(destination: OTPVerificationView()) {
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
                    }
                    .foregroundColor(Color("MainColor"))
                    .font(.custom("AmericanTypewriter", size: 36))
                    .multilineTextAlignment(.center)
                }
          }
      }
}


#Preview {
    SignUpView()
}
