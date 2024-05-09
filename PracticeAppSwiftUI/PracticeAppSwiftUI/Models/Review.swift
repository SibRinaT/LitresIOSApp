//
//  Review.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import Foundation

struct Review: Codable, Identifiable {
    var id = UUID().uuidString
    var bookId: String
    var reviewText: String
    var userName: String
    var rating: Int
    var reviewDate: Date
    
    init(bookId: String, reviewText: String, userName: String, rating: Int) {
        self.bookId = bookId
        self.reviewText = reviewText
        self.userName = userName
        self.rating = rating
        self.reviewDate = Date()
    }
}
