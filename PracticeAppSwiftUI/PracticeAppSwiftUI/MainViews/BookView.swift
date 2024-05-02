//
//  BookView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI
import Foundation

struct BookView: View {
    var book: Book
        
    var body: some View {
        VStack(alignment: .leading) {
            Image(book.imageName, bundle: nil)
                .resizable()
                .frame(width: 200, height: 200)
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "heart.circle")
                        .font(.largeTitle)
                        .symbolVariant(book.isLiked ? .fill : .none)
                        .foregroundColor(.white)
                        .padding(15)
                }
                .padding()
            Text(book.name)
                .foregroundStyle(.black)
                .font(.title2)
                .lineLimit(1)
            Text(book.author.name)
                .foregroundStyle(.gray)
                .font(.title2)
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
                .padding()
                .background(Color("MainColor"))
                .cornerRadius(30.0)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(String(format: "%.1f", book.rating))
                }
            }
        }
    }
}

#Preview {
    BookView(book: MockData.getBook())
}
