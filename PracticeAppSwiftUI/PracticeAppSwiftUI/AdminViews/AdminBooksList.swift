//
//  AdminBooksList.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import SwiftUI

struct AdminBooksList: View {
    @State var books = [Book1]()
    
    var body: some View {
        List {
            ForEach(books) { book in
                Text(book.name)
            }
            .onDelete(perform: deleteBooks)
        }
        
        .navigationTitle("Books")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AdminAddBookView()) {
                    Text("+ книга")
                }

            }
        }
        .task {
            do {
                books = try await Store.shared.getBooks()
            } catch {
                print(error)
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        for i in offsets {
            Store.shared.delete(book: books[i])
        }
    }
}

#Preview {
    AdminBooksList()
}
