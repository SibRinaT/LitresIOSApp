//
//  FileStore+Genre.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import Foundation
import FirebaseFirestore

extension Store {
    private var genreCollection: String { "bookGenre" }
    
    func getGenres() async throws -> [BookGenre] {
        let docs = try await db.collection(genreCollection).getDocuments()
        return docs.documents.compactMap { try? $0.data(as: BookGenre.self) }
    }
}
