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

class Book: Identifiable, Equatable {
    var id: String //
    var name: String//
    var shortDesc: String
    var imageName: String
    var author: User//
    var shelf: Shelf
    var isLiked: Bool
    var rating: Double//
    var releaseYear: Int//
    var bookType: BookType
    var audioBookDetails: AudioBookDetails?
    var textBookDetails: TextBookDetails?
    var tags: [Tag]
    var linkedBook: Book?
    var content: BookContent?
    var description: String//
    var publisher: String
    var creatingDate: Date
    var reviews: [Review]
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: String, name: String, shortDesc: String = "", imageName: String, author: User, shelf: Shelf, isLiked: Bool, rating: Double, releaseYear: Int, bookType: BookType, audioBookDetails: AudioBookDetails? = nil, textBookDetails: TextBookDetails? = nil, tags: [Tag], linkedBook: Book? = nil, content: BookContent?, description: String, publisher: String, creatingDate: Date, reviews: [Review]) {
        self.id = id
        self.name = name
        self.shortDesc = shortDesc
        self.imageName = imageName
        self.author = author
        self.shelf = shelf
        self.isLiked = isLiked
        self.rating = rating
        self.releaseYear = releaseYear
        self.bookType = bookType
        self.audioBookDetails = audioBookDetails
        self.textBookDetails = textBookDetails
        self.tags = tags
        self.linkedBook = linkedBook
        self.content = content
        self.description = description
        self.publisher = publisher
        self.creatingDate = creatingDate
        self.reviews = reviews
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
