//
//  Book.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import Foundation

enum Shelf: String, CaseIterable {
    case Популярное
    case Рекомендация
    case Релизы
    case Хиты
    case ВыборСоздателей
}

enum BookType: String, CaseIterable {
    case text = "E-book"
    case audio = "Audiobook"
}

struct Hotel: Codable {
    
    let id: Int
    let name: String
    let adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: HotelInfo
    
    struct HotelInfo: Codable {
        let description: String
        let peculiarities: [String]
    }
}

struct BookFormat: Codable, Hashable {
    let name: String
}

struct BookGenre: Codable, Hashable {
    let name: String
}

struct Book1: Codable, Identifiable, Hashable {    
    private(set) var id: String
    private(set) var firestoreId: String?
    private(set) var imageUrl: String?
    let name: String
    let year: Int?
    let format: BookFormat?
    let description: String?
    let genre: String
    let authorName: String?
    let bookType: String
    var rating = 0.0
    
    var imageId: String {
        id
    }
    
    init(id: String,
         name: String,
         year: Int?,
         format: BookFormat?,
         description: String?,
         genre: String,
         authorName: String,
         bookType: String) {
        self.id = id
        self.name = name
        self.year = year
        self.format = format
        self.description = description
        self.genre = genre
        self.authorName = authorName
        self.bookType = bookType
    }
    
    mutating func set(firestoreId: String) {
        self.firestoreId = firestoreId
    }
    
    mutating func set(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}


class BookContent {
    var fakeBookTextContent: String?
    var fakeBookAudioContent: Data?
}

struct AudioBookDetails {
    var length: String
    var audioAuthor: String
}

struct TextBookDetails {
    var pages: Int
}

struct User {
    var id: Int
    var name: String
    var isSubscriptionEnabled: Bool?
}
