//
//  FireStore+Review.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 09.05.2024.
//

import Foundation
import FirebaseFirestore

extension Store {
    private var reviewCollection: String { "bookReview" }
    
    func getReviews(for bookId: String? = nil) async throws -> [Review] {
        let snapshot: QuerySnapshot
        if let bookId {
            snapshot = try await db.collection(reviewCollection)
                .whereField("bookId", isEqualTo: bookId)
                .getDocuments()
        } else {
            snapshot = try await db.collection(reviewCollection)
                .getDocuments()
        }
        var reviews = [Review]()
        for document in snapshot.documents {
            if var review = try? document.data(as: Review.self) {
                review.set(firestoreId: document.documentID)
                reviews.append(review)
            }
        }
        return reviews
    }
    
    func add(review: Review) throws {
        try db.collection(reviewCollection).addDocument(from: review)
    }
    
    func update(reviewId: String, text: String, rating: Int) async throws {
        let ref = db.collection(reviewCollection).document(reviewId)
        try await ref.updateData(["reviewText": text, "rating": rating])
    }
    
    func delete(review: Review) async throws {
        if let firestoreId = review.firestoreId {
            try await db.collection(reviewCollection)
                .document(firestoreId)
                .delete()
        } else {
            print("No firestore Id on review struct!")
        }
    }
}
