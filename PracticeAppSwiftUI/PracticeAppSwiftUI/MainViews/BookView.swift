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
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(.black).opacity(0.26))
                .cornerRadius(35)
                .overlay {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: book.imageUrl ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: 200.0, height: 200.0)
                        } placeholder: {
                            Image("book")
                        }
//                            .overlay(alignment: .topTrailing) {
//                                Image(systemName: "heart.circle")
//                                    .font(.largeTitle)
//                                    .symbolVariant(book.isLiked ? .fill : .none)
//                                    .foregroundColor(.white)
//                                    .padding(15)
//                            }
//                            .padding()
                        Text(book.name)
                            .foregroundColor(.white)
                            .font(.title2)
                            .lineLimit(1)
                        if let authorName = book.authorName {
                            Text(authorName)
                                .foregroundColor(.white)
                                .font(.title2)
                                .lineLimit(1)
                        }

                        
                        HStack {
                            HStack {
                                switch BookType(rawValue: book.bookType) {
                                case .text:
                                    Image(systemName: "book")
                                        .foregroundColor(.white)
                                case .audio:
                                    Image(systemName: "headphones")
                                        .foregroundColor(.white)
                                case .none:
                                    Color.white
                                }
                            }
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(30.0)
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text(String(format: "%.1f", book.rating))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .frame(width: 300, height: 400)
        }
    }
}

//#Preview {
//    BookView(book: Book1(id: "", name: "", year: nil, format: nil, description: nil, genre: "", authorName: ""))
//}
