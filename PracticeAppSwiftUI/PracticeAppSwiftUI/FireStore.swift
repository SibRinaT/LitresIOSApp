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
    let name: String
    let year: Int
    let format: BookFormat?
}

struct Store {
    let db = Firestore.firestore()
    
    func addBook() {
        Task {
            do {
                let ref = try db.collection("books").addDocument(from: Book1(name: "TEST", year: 9999, format: BookFormat(name: "")))
                //                let ref = try await db.collection("books").addDocument(data: [
                //                    "name": "A secret book",
                //                    "year": 1987
                //                ])
                print("Document added with ID: \(ref.documentID)")
            } catch {
                print("Error adding document: \(error)")
            }
        }
    }
    
    func getBooks() async throws -> [Book1] {
        do {
            let snapshot = try await db.collection("books").getDocuments()
            for document in snapshot.documents {
                let book = try document.data(as: Book1.self)
                print(book)
                print("\(document.documentID) => \(document.data())")
            }
            return []
        } catch {
            print("Error getting documents: \(error)")
            return []
        }
    }
}
