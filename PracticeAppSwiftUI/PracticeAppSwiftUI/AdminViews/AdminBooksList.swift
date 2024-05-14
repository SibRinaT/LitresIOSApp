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
        VStack(alignment: .leading) {
            NavigationLink(destination: AdminEditBookView(viewType: .add)) {
                Text("Добавить книгу")
                    .padding()
            }
            List {
                ForEach(books) { book in
                    HStack {
                        AsyncImage(url: URL(string: book.imageUrl ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                        } placeholder: {
//                            Image("book")
//                                .frame(width: 50.0, height: 50.0)
                        }
                        NavigationLink(destination: AdminEditBookView(viewType: .edit(book: book))) {
                            Text(book.name)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
        }
        .navigationTitle("Books")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
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
