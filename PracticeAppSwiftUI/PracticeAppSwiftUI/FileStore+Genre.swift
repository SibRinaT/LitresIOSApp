//
//  FileStore+Genre.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import Foundation
import FirebaseFirestore

extension Store {
    func getGenres() async throws -> [BookGenre] {
        do {
            let snapshot = try await db.collection("bookGenre").getDocuments()
            var genres = [BookGenre]()
            for document in snapshot.documents {
                if var genre = try? document.data(as: BookGenre.self) {
                    genres.append(genre)
                }
            }
            return genres
        } catch {
            print("Error getting documents: \(error)")
            return []
        }
    }
}
