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
    
    func add(review: Review) throws {
        try db.collection(reviewCollection).addDocument(from: review)
    }
    
    func getReviewsFor(bookId: String) async throws -> [Review] {
        let docs = try await db.collection(reviewCollection)
            .whereField("bookId", isEqualTo: bookId).getDocuments()
        return docs.documents
            .compactMap { try? $0.data(as: Review.self) }
    }
}
