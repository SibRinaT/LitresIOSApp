//
//  MockData.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct MockData {
    static var sharedBooks: [Book]?
    
    static private let bookImageNames = ["bookImage0", "bookImage1", "bookImage2", "bookImage3"]
    static private let bookNames = ["Harry Potter", "Lord of the Rings", "Star Wars", "Приключения Антошки"]
    static private let audioAuthors = ["Всеволод Кузнецов", "Татьяна Шитова", "Сергей Бурунов", "Владимир Вихров"]
    static private let shortDesc = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit", " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris", "nisi ut aliquip ex ea commodo consequat"]
    static private let descriptions = ["Властелин Колец» Джона Толкина повествует о Великой войне за Кольцо, о войне, длившейся не одну тысячу лет. Овладевший Кольцом получает власть над всем живым и мертвым, но при этом должен служить Злу!",
        "Цикл «Ведьмак» относится к жанру эпического фэнтези, но по общей стилистике заметно отступает от канонов этого жанра. Вместо чёткого разделения добра и зла, Сапковский рисует картину жестокого средневековья, в котором ведется борьба народов и государств.", "Книга написана в жанре фантастики и фэнтези. Она рассказывает о приключениях хоббита Бильбо, который отправляется в путешествие вместе с гномами и волшебником Гэндальфом. Они ищут пропавшие сокровища, но на их пути встречаются множество опасностей."]
    static private let publishers = ["Автор", "МоскваКниги", "LondonBooks"]
    
//    static let creatingDates = ["15 ноября 2023", "12 декабря 2022"]
    
    static private let authors = [User(id: 123, name: "Андрей Булычев"),
                          User(id: 124, name: "Василий Маханенко"),
                          User(id: 125, name: "Сергей Лукьяненко")]
    static private let tags = [Tag(name: "Fiction"),
                               Tag(name: "Aliens"),
                               Tag(name: "Sci-fi"),
                               Tag(name: "Хоррор"),
                               Tag(name: "Elves"),
                               Tag(name: "Fan fiction"),
                               Tag(name: "Humor"),
                               Tag(name: "SuperSuperLongTagName"),
                               Tag(name: "Романтика"),
                               Tag(name: "ЛитРпг"),
                               Tag(name: "2"),
                               Tag(name: "3"),
                               Tag(name: "4"),
                               Tag(name: "1")]

    static private let reviews =
    [Review(reviewText: "Очень классная книга, мне понравилось", userName: "Jhon", userImageURL: "https://i.pravatar.cc/80", rating: Int.random(in: 0..<5), reviewDate: Date()),
    Review(reviewText: "Я просто в восторге это что что с чем то!", userName: "Jane", userImageURL: "https://i.pravatar.cc/80", rating: Int.random(in: 0..<5), reviewDate: Date()),
    Review(reviewText: "Автор этой книги гений, я просто апплодирую стоя...", userName: "Mary", userImageURL: "https://i.pravatar.cc/80", rating: Int.random(in: 0..<5), reviewDate: Date()),
    ]
    static private func generateBook(id: String = UUID().uuidString,
                             hasLinkedBook: Bool = true,
                             bookType: BookType? = nil
    ) -> Book {
        
        let bookType = bookType ?? BookType.allCases.randomElement()!
        var audioBookDetails: AudioBookDetails?
        var textBookDetails: TextBookDetails?
        switch bookType {
        case .text:
            textBookDetails = TextBookDetails(pages: Int.random(in: 1..<999))
        case .audio:
            audioBookDetails = AudioBookDetails(length: "12:12:00", audioAuthor: MockData.audioAuthors.randomElement()!)
        }
        
        var linkedBook: Book?
        if hasLinkedBook {
            switch bookType {
            case .text:
                linkedBook = generateBook(hasLinkedBook: false, bookType: .audio)
            case .audio:
                linkedBook = generateBook(hasLinkedBook: false, bookType: .text)
            }
        }
        let secondsInYearMin = 60 * 60 * 24 * 31 * 12
        let randomDate = Date().addingTimeInterval(TimeInterval(Int.random(in: secondsInYearMin..<secondsInYearMin * 10)))
        
        return Book(id: id,
                    name: bookNames.randomElement()!,
                    shortDesc: shortDesc.randomElement()!,
                    imageName: bookImageNames.randomElement()!,
                    author: authors.randomElement()!,
                    shelf: Shelf.allCases.randomElement()!,
                    isLiked: Bool.random(),
                    rating: Double.random(in: 1..<5),
                    releaseYear: Int.random(in: 1900..<2024),
                    bookType: bookType,
                    audioBookDetails: audioBookDetails,
                    textBookDetails: textBookDetails,
                    tags: Array(tags.shuffled().prefix(Int.random(in: 1...5))),
                    linkedBook: linkedBook,
                    content: nil,
                    description: descriptions.randomElement()!,
                    publisher: publishers.randomElement()!,
                    creatingDate: randomDate,
                    reviews: Array(reviews.shuffled().prefix(Int.random(in: 0...3)))
        )
    }
    
    static private func generateBooks() -> [Book] {
        var books = [Book]()
        print("Generating books")
        for _ in (0...100) { books.append(generateBook(id: UUID().uuidString, hasLinkedBook: Bool.random())) }
        sharedBooks = books
        return books
    }
    
    
    static func getBooks(count: Int = 100) -> [Book] {
        let books = sharedBooks ?? generateBooks()
        return Array(books.prefix(count))
    }
    
    static func getBook() -> Book {
        getBooks(count: 1).first!
    }
}
