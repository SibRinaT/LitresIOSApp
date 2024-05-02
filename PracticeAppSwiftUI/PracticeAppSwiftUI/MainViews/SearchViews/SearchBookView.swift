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
            Image(book.imageName, bundle: nil)
                .resizable()
                .frame(width: 120)
                .aspectRatio(1, contentMode: .fill)
            VStack(alignment: .leading) {
                Text(book.name)
                    .foregroundStyle(.black)
                    .font(.headline)
                .lineLimit(1)
                Text(book.author.name)
                    .foregroundStyle(.gray)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    HStack {
                        switch book.bookType {
                        case .text:
                            Image(systemName: "book")
                        case .audio:
                            Image(systemName: "headphones")
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
            Image(systemName: "heart")
                .font(.title2)
                .symbolVariant(book.isLiked ? .fill : .none)
        }
    }
}

#Preview {
    List {
        SearchBookView(book: MockData.getBook())
    }
    
}
