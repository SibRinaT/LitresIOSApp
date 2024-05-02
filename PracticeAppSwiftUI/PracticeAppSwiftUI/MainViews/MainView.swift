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
                Image(systemName: "book.circle.fill")
                Text("Книги")
            }
        }
    }
}

#Preview {
    MainView()
}
