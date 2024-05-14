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

struct Book: Codable, Identifiable, Hashable {    
    private(set) var id: String
    private(set) var firestoreId: String?
    let name: String
    let year: Int?
    let format: BookFormat?
    let description: String?
    let genre: String
    let authorName: String?
    let bookType: String
    let isFree: Bool
    var rating = 0.0
    let imageUrl: String?
    let fileName: String?

    init(id: String,
         name: String,
         year: Int?,
         format: BookFormat?,
         description: String?,
         genre: String,
         authorName: String,
         isFree: Bool,
         bookType: String,
         imageUrl: String?,
         fileName: String?)
    {
        self.id = id
        self.name = name
        self.year = year
        self.format = format
        self.description = description
        self.genre = genre
        self.authorName = authorName
        self.isFree = isFree
        self.bookType = bookType
        self.imageUrl = imageUrl
        self.fileName = fileName
    }
    
    mutating func set(firestoreId: String) {
        self.firestoreId = firestoreId
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

struct User: Codable {
    let id: String
    let name: String
    let isAdmin: Bool
    private(set) var isSubscriptionEnabled: Bool
    
    mutating func enableSubscription() {
        isSubscriptionEnabled = true
    }
    
    init(id: String, name: String, isAdmin: Bool) {
        self.id = id
        self.name = name
        self.isAdmin = isAdmin
        self.isSubscriptionEnabled = false
    }
}
