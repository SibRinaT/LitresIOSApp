//
//  ShelfView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct ShelfView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass

    var shelfName: String
    var books: [Book]
    
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                Text(shelfName)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(books, id: \.id) { book in
                            NavigationLink(destination: BookDetails(book: book)) {
                                BookView(book: book)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShelfView(shelfName: "New Releases", books: MockData.getBooks(count: 10))
}
