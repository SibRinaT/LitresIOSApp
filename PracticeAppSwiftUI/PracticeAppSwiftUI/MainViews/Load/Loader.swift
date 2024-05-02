//
//  Loader.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation

@MainActor
struct Loader {

    func loadBooks(with tagId: String, result: @escaping (Result<[Book], CustomError>) -> Void) {
        let filteredBooks = MockData
            .getBooks()
            .filter { $0.tags.contains { $0.id == tagId } }
        result(.success(filteredBooks))
    }
    
    func loadHotel(result: @escaping (Hotel?) -> ()) {
        
    }
}
