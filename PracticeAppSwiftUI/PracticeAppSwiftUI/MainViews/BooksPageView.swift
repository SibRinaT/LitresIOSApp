//
//  BooksPageView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI
import SwiftData

struct BooksPageView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackColor")
                    .ignoresSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(Shelf.allCases.map{ $0.rawValue }, id: \.self) { shelf in
                            ShelfView(shelfName: shelf, books: MockData.getBooks())
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BooksPageView()
}
