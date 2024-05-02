//
//  BookDetailsHeader.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

struct BookDetailsHeader: View {
    var book: Book
    var textBookContent: String = "Оглавление"

    
    var body: some View {
        ZStack {
            Image(book.imageName, bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)

                .visualEffect { content, geometryProxy in
                    content
                        .blur(radius: 20)
                        .brightness(-0.3)
                }
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 40)
                            .foregroundColor(.white)
                        
                        VStack {
                            Text(String(format: "%.1f", book.rating))
                            Text("\(book.reviews.count)")
                                .font(.system(size: 14))
                                .foregroundColor(.capsuleGray)
                        }
                        .font(.callout)

                        .foregroundColor(.white)
                        Image(book.imageName, bundle: nil)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 200)
                        Button(action: {
                            
                        }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text(textBookContent)
                                    .font(.callout)
                                    .foregroundColor(.capsuleGray)

                            }
                        }
                    }
                    VStack {
                        HStack {
                            Text(book.name)
                                .bold()
                                .font(.system(size: 18))
                            switch book.bookType {
                            case .text:
                                Capsule()
                                    .foregroundColor(.capsuleBlue)
                                    .frame(width: 70 , height: 30)
                                    .overlay {
                                        Text("Текст")
                                            .font(.callout)
                                    }
                            case .audio:
                                Capsule()
                                    .foregroundColor(.capsuleBlue)
                                    .frame(width: 70 , height: 30)
                                    .overlay {
                                        Text("Аудио")
                                            .font(.callout)
                                    }
                            }
                        }
                        .foregroundColor(.white)

                        HStack {
                            Button(action: {
                                
                            }) {
                                Text(book.author.name)
                                    .foregroundColor(.capsuleGray)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.capsuleGray)
                            }
                            .font(.callout)
                        }
                        if let authorName = book.audioBookDetails?.audioAuthor, book.bookType == .audio {
                            HStack {
                                Text("Is reading")
                                    .font(.callout)
                                    .foregroundColor(.white)
                                Button(action: {
                                    
                                }) {
                                    HStack {
                                        Text(authorName)
                                        Image(systemName: "chevron.right")
                                    }
                                    .foregroundColor(.capsuleGray)
                                    .foregroundColor(.white)
                                }
                                .font(.callout)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BookDetailsHeader(book: MockData.getBook())
}
