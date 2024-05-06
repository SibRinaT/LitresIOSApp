//
//  FireStore.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import Foundation
import FirebaseFirestore

struct BookFormat: Codable {
    let name: String
}

struct Book1: Codable, Identifiable {
    private(set) var id: String
    private(set) var firestoreId: String?
    let name: String
    let year: Int?
    let format: BookFormat?
    let description: String?
    
    init(id: String, name: String, year: Int?, format: BookFormat?, description: String?) {
        self.id = id
        self.name = name
        self.year = year
        self.format = format
        self.description = description
    }
    
    mutating func set(firestoreId: String) {
        self.firestoreId = firestoreId
    }
}

struct Store {
    static let shared = Store()
    let db = Firestore.firestore()
    
    func add(book: Book1, imageData: Data) async throws {
        try await ImageStorage.shared.upload(imageData: imageData, name: book.id)
        try db.collection("books").addDocument(from: book)
    }
    
    func update(book: Book1, imageData: Data?) async throws {
        guard let firestoreId = book.firestoreId else {
            throw ApiError.custom(text: "No firestoreId assigned to the book")
        }
        if let imageData {
            print("Update book with new image")
            // available imageData means that image has been changed.
            // Removing old image, uploading new one
            try await ImageStorage.shared.deleteImage(with: book.id)
            try await ImageStorage.shared.upload(imageData: imageData, name: book.id)
        } else {
            print("Update book without image update")
        }
        let ref = db.collection("books").document(firestoreId)
        try await ref.updateData(book.asDictionary())
    }
    
    func delete(book: Book1) async throws {
        if let firestoreId = book.firestoreId {
            try await db.collection("books").document(firestoreId).delete()
            try await ImageStorage.shared.deleteImage(with: book.id)
        } else {
            print("No firestore Id on book struct!")
        }
    }
    
    func getBooks() async throws -> [Book1] {
        do {
            let snapshot = try await db.collection("books").getDocuments()
            var books = [Book1]()
            for document in snapshot.documents {
                if var book = try? document.data(as: Book1.self) {
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
