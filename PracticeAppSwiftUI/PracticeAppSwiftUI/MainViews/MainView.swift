//
//  MainView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            NavigationView {
                BooksPageView()
            }
            .tabItem {
                Image(systemName: "trophy.circle.fill")
                Text("Подписка")
            }
            NavigationView {
                BooksPageView()
            }
            .tabItem {
                Image(systemName: "book.circle.fill")
                    .foregroundColor(Color("MainColor"))
                Text("Книги")
            }
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Профиль")
            }
        }
    }
}

#Preview {
    MainView()
}
