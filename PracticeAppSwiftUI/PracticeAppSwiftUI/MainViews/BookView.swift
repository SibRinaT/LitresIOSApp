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
                            .foregroundColor(.white)
                            .font(.title2)
                            .lineLimit(1)
                        Text(book.author.name)
                            .foregroundColor(.white)
                            .font(.title2)
                            .lineLimit(1)
                        
                        HStack {
                            HStack {
                                switch book.bookType {
                                case .text:
                                    Image(systemName: "book")
                                        .foregroundColor(.white)
                                case .audio:
                                    Image(systemName: "headphones")
                                        .foregroundColor(.white)
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

#Preview {
    BookView(book: MockData.getBook())
}
