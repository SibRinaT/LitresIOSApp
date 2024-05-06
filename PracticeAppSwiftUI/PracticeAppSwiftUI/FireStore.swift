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

struct Book1: Codable {
    private(set) var id: String
    let name: String
    let year: Int?
    let format: BookFormat?
    
    init(id: String, name: String, year: Int?, format: BookFormat?) {
        self.id = id
        self.name = name
        self.year = year
        self.format = format
    }
    
    mutating func set(id: String) {
        self.id = id
    }
}

struct Store {
    static let shared = Store()
    let db = Firestore.firestore()
    
    func add(book: Book1, imageData: Data) async throws {
        try await ImageStorage.shared.upload(imageData: imageData, name: book.id)
        try db.collection("books").addDocument(from: book)
    }
    
    func delete(book: Book1) {
        
    }
    
    func getBooks() async throws -> [Book1] {
        do {
            let snapshot = try await db.collection("books").getDocuments()
            var books = [Book1]()
            for document in snapshot.documents {
                if let book = try? document.data(as: Book1.self) {
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
