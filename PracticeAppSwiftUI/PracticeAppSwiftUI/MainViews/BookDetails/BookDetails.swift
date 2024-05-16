//
//  BookDetails.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct BookDetails: View {
    var book: Book
    @State private var reviews = [Review]()
    @State private var rating = 0.0
    
    var body: some View {
        ScrollView {
            BookDetailsHeader(book: book, rating: $rating)
            BookDetailsBody(book: book, reviews: $reviews)
        }
        .background(Color("BackColor").ignoresSafeArea(.all))
        .task {
            do {
                self.reviews = try await Store.shared.getReviews(for: book.id)
                self.rating = calculateRating()
                if let bookId = self.book.firestoreId {
                    try await Store.shared.update(rating: self.rating, for: bookId)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func calculateRating() -> Double {
        guard !reviews.isEmpty else { return 0 }
        let totalReviewsRating = reviews
            .map { $0.rating }
            .reduce(0, { $0 + $1 })
        return Double(totalReviewsRating) / Double(reviews.count)
    }
}
