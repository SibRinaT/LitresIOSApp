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
    
    func add(book: Book, imageData: Data) async throws {
        let imageUrl = try await ImageStorage.shared.upload(imageData: imageData,
                                             imageId: book.imageId)
        var mutableBook = book
        mutableBook.set(imageUrl: imageUrl.absoluteString)
        try db.collection("books").addDocument(from: mutableBook)
    }
    
    func update(book: Book, imageData: Data?) async throws {
        guard let firestoreId = book.firestoreId else {
            throw ApiError.custom(text: "No firestoreId assigned to the book")
        }
        if let imageData {
            print("Update book with new image")
            // available imageData means that image has been changed.
            // Removing old image, uploading new one
            try await ImageStorage.shared.deleteImageWith(id: book.imageId)
            try await ImageStorage.shared.upload(imageData: imageData,
                                                 imageId: book.imageId)
        } else {
            print("Update book without image update")
        }
        let ref = db.collection("books").document(firestoreId)
        try await ref.updateData(book.asDictionary())
    }
    
    func delete(book: Book) async throws {
        if let firestoreId = book.firestoreId {
            try await db.collection("books").document(firestoreId).delete()
            try await ImageStorage.shared.deleteImageWith(id: book.imageId)
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
