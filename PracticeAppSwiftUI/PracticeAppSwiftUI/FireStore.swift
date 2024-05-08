//
//  FireStore.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import Foundation
import FirebaseFirestore

struct Store {
    static let shared = Store()
    let db = Firestore.firestore()
    
    func add(book: Book) async throws {
        try db.collection("books").addDocument(from: book)
    }
    
    func update(book: Book) async throws {
        guard let firestoreId = book.firestoreId else {
            throw ApiError.custom(text: "No firestoreId assigned to the book")
        }
        let ref = db.collection("books").document(firestoreId)
        try await ref.updateData(book.asDictionary())
    }
    
    func delete(book: Book) async throws {
        if let firestoreId = book.firestoreId {
            try await db.collection("books").document(firestoreId).delete()
            if let url = URL(string: book.imageUrl ?? "") {
                let imageName = url.deletingPathExtension().lastPathComponent
                let path = "images/\(imageName).jpg"
                try await ImageStorage.shared.deleteFileFrom(path: path)
            }
        } else {
            print("No firestore Id on book struct!")
        }
    }
    
    func getBooks() async throws -> [Book] {
        do {
            let snapshot = try await db.collection("books").getDocuments()
            var books = [Book]()
            for document in snapshot.documents {
                if var book = try? document.data(as: Book.self) {
                    book.set(firestoreId: document.documentID)
                    books.append(book)
                }
            }
            return books
        } catch {
            print("Error getting documents: \(error)")
            return []
        }
    }
}

private extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
