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
    
    func add(book: Book1, imageData: Data) {
        Task {
            do {
                
                try await ImageStorage.shared.upload(imageData: imageData,
                                                               name: book.id)
                let ref = try db.collection("books").addDocument(from: book)

            } catch {
                print("Error adding document: \(error)")
            }
        }
    }
    
    func getBooks() async throws -> [Book1] {
        do {
            let snapshot = try await db.collection("books").getDocuments()
            var books = [Book1]()
            for document in snapshot.documents {
                var book = try document.data(as: Book1.self)
                book.set(id: document.documentID)
                books.append(book)
            }
            return books
        } catch {
            print("Error getting documents: \(error)")
            return []
        }
    }
}
