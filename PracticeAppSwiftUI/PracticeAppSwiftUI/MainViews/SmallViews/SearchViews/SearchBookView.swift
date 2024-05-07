//
//  SearchBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

struct SearchBookView: View {
    var book: Book
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: book.imageUrl ?? "")) { image in
                image
                    .frame(width: 120)
                    .aspectRatio(1, contentMode: .fill)
            } placeholder: {
                Image("book")
            }

            VStack(alignment: .leading) {
                Text(book.name)
                    .foregroundStyle(.black)
                    .font(.headline)
                .lineLimit(1)
                Text(book.authorName ?? "")
                    .foregroundStyle(.gray)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    HStack {
                        switch BookType(rawValue: book.bookType) {
                        case .text:
                            Image(systemName: "book")
                        case .audio:
                            Image(systemName: "headphones")
                        case .none:
                            Color.white
                        }
                    }
                    .font(.callout)
                    .padding(10)
                    .background(Color("MainColor"))
                    .cornerRadius(30.0)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("\(book.rating)")
                    }
                }
            }
            Spacer()
//            Image(systemName: "heart")
//                .font(.title2)
//                .symbolVariant(book.isLiked ? .fill : .none)
        }
    }
}

//#Preview {
//    List {
//        SearchBookView(book: MockData.getBook())
//    }
//    
//}
