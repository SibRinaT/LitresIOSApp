//
//  Review.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import Foundation

struct Review: Identifiable {
    var id = UUID().uuidString
    var reviewText: String
    var userName: String
    var userImageURL: String
    var rating: Int
    var reviewDate: Date
}
