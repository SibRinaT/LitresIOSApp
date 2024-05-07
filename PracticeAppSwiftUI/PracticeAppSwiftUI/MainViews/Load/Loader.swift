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
        result(.success([]))
    }

}
