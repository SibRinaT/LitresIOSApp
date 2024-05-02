//
//  BookDetailsBody.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

import Foundation
import SwiftUI

struct BookDetailsBody: View {
    var book: Book
    @State var isExpanded = false
    @State private var selectedTab = "One"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(book.bookType.rawValue)
                    Text("Release date: \(book.releaseYear)")
                    switch book.bookType {
                    case .text:
                        if let pages = book.textBookDetails?.pages {
                            Text("Pages: \(pages)")
                        }
                    case .audio:
                        if let len = book.audioBookDetails?.length {
                            Text("Length: \(len)")
                        }
                    }
                }
                Spacer()
                if let linkedBook = book.linkedBook {
                    SwitchBookTypeView(book: linkedBook)
                }
            }
            .padding(.vertical)
            TagsView(tags: book.tags)
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: { Text(book.description)},
                label: { Text("Описание книги \(book.name)") }
            )
            .foregroundColor(.black)
            Text("\nИздатель: \(book.publisher)")
            Text("Дата выхода на ЧитайBook: \(book.creatingDate.formatted(date: .long, time: .omitted))")
            Spacer(minLength: 20)
            if !book.reviews.isEmpty {
                Text(book.reviews.count == 1 ? "Отзыв" : "Отзывы")
                    .font(.largeTitle)
                    .bold()
            }
            ForEach(book.reviews) { review in
                BookReview(review: review)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
//        NavigationView {
//                       NavigationLink(destination: PlaysoundView()) {
//                           Text("Перейти к проигрывателю")
//                       }
//                   }
//        .padding()
    }
}

#Preview {
    NavigationStack {
        BookDetails(book: MockData.getBook())
    }
}
