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
            }
            .foregroundColor(Color("PrimaryColor"))
            .font(.custom("AmericanTypewriter", size: 36))
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContentView()
}
