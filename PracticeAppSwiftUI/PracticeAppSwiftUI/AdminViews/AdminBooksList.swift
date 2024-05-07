//
//  AdminBooksList.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import SwiftUI

struct AdminBooksList: View {
    @State var books = [Book]()
    
    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink(destination: AdminEditBookView(viewType: .edit(book: book))) {
                    Text(book.name)
                }
            }
            .onDelete(perform: deleteBooks)
        }
        
        .navigationTitle("Books")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AdminEditBookView(viewType: .add)) {
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
        Task {
            for i in offsets {
                try await Store.shared.delete(book: books[i])
            }
        }

    }
}

#Preview {
    AdminBooksList()
}
