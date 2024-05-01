//
//  LogInView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import SwiftUI

struct LogInView: View {
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
                    
                    InputFieldView(title: "email", placeholder: "book@gmail.com", text: "")
                    
                    PasswordFieldView(title: "пароль", placeholder: "book123", text: "")
                        .padding(-20)
                    
                    VStack {
                        Text("У вас нет аккаунта?")
                            .foregroundColor(.white)
                        NavigationLink(destination: SignUpView()) {
                            Text("Начните чтение!")
                                .foregroundColor(Color("MainColor"))
                        }
                    }
                    .padding(3)
                    
                    .font(.custom("AmericanTypewriter", size: 14))
                    .multilineTextAlignment(.center)
                    NavigationLink(destination: MainView()) {
                        Rectangle()
                            .frame(width: 224, height: 50)
                            .cornerRadius(16)
                            .foregroundColor(Color("MainColor"))
                            .overlay(
                                Text("Вход")
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
    LogInView()
}
