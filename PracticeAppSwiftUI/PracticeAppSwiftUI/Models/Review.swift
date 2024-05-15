//
//  Review.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import Foundation

struct Review: Codable, Identifiable {
    var id: String
    private(set) var firestoreId: String?
    var bookId: String
    var reviewText: String
    var userName: String
    var rating: Int
    var reviewDate: Date
    
    init(id: String, bookId: String, reviewText: String, userName: String, rating: Int, reviewDate: Date) {
        self.id = id
        self.bookId = bookId
        self.reviewText = reviewText
        self.userName = userName
        self.rating = rating
        self.reviewDate = reviewDate
    }
    
    mutating func set(firestoreId: String) {
        self.firestoreId = firestoreId
    }
}
