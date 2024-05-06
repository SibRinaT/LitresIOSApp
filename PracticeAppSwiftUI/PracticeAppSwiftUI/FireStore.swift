//
//  FireStore.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 05.05.2024.
//

import Foundation
import FirebaseFirestore

struct Store {
    let db = Firestore.firestore()

    func addBook() {
        Task {
            do {
                let ref = try await db.collection("books").addDocument(data: [
                    "name": "A secret book",
                    "year": 1987
                ])
                print("Document added with ID: \(ref.documentID)")
            } catch {
                print("Error adding document: \(error)")
            }
        }
    }
}
