//
//  BooksPageView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI
import SwiftData

fileprivate struct BooksShelf {
    let genre: BookGenre
    let books: [Book]
}

struct BooksPageView: View {
    @State private var shelfs = [BooksShelf]()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackColor")
                    .ignoresSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(shelfs, id: \.genre.name) { shelf in
                            if !shelf.books.isEmpty {
                                ShelfView(shelfName: shelf.genre.name,
                                          books: shelf.books)
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
            .task {
                do {
                    shelfs.removeAll()
                    let genresArray = try await Store.shared.getGenres()
                    let books = try await Store.shared.getBooks()
                    for genre in genresArray {
                        let booksForGenre = books.filter { $0.genre == genre.name }
                        let shelf = BooksShelf(genre: genre,
                                               books: booksForGenre)
                        shelfs.append(shelf)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    BooksPageView()
}
