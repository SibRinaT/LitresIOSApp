//
//  ContentView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
                InputFieldView(title: "email", placeholder: "book@gmail.com", text: "")
                InputFieldView(title: "логин", placeholder: "user", text: "")
                    .padding(-20)
                PasswordFieldView(title: "пароль", placeholder: "book123", text: "")
                PasswordFieldView(title: "повторите пароль", placeholder: "book123", text: "")
                    .padding(-20)
                
            }
                        .foregroundColor(Color("MainColor"))
            .font(.custom("AmericanTypewriter", size: 36))
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContentView()
}
