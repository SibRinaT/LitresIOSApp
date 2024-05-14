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
            Color("BackColor")
                .ignoresSafeArea(.all)
            
            AsyncImage(url: URL(string: book.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .visualEffect { content, geometryProxy in
                        content
                            .blur(radius: 20)
                            .brightness(-0.3)
                    }
            } placeholder: {}
            
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
                                .font(.custom("AmericanTypewriter", size: 16))
                                .foregroundColor(Color(.white))
//                            Text("\(book.reviews.count)")
//                                .font(.system(size: 14))
//                                .foregroundColor(Color("MainColor"))
                        }
                        .font(.callout)
                        .foregroundColor(.white)
                        
                        AsyncImage(url: URL(string: book.imageUrl ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(height: 200)
                        } placeholder: {}

                        Button(action: {
                            
                        }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .font(.custom("AmericanTypewriter", size: 20))
                                    .foregroundColor(Color(.white))
                                    .foregroundColor(.white)
                                Text(textBookContent)
                                    .font(.custom("AmericanTypewriter", size: 14))
                                    .foregroundColor(Color(.white))
                                
                                Rectangle()
                                    .frame(width: 150, height: 50)
                                    .foregroundColor(Color("SecondaryColor"))
                                    .cornerRadius(14)
                                    .overlay(
                                        if book.isFree {
                                            Text("Бесплатная")
                                        } else {
                                            Text("По подписке")
                                        }
                                    )
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Text(book.name)
                                .bold()
                                .font(.custom("AmericanTypewriter", size: 20))
                                .foregroundColor(Color(.white))
                            switch BookType(rawValue: book.bookType) {
                            case .text:
                                Capsule()
                                    .foregroundColor(Color("MainColor"))
                                    .frame(width: 70 , height: 30)
                                    .overlay {
                                        Text("Текст")
                                            .font(.callout)
                                    }
                            case .audio:
                                Capsule()
                                    .foregroundColor(Color("MainColor"))
                                    .frame(width: 70 , height: 30)
                                    .overlay {
                                        Text("Аудио")
                                            .font(.callout)
                                    }
                            case .none:
                                Color.white
                            }
                        }
                        .foregroundColor(.white)

                        HStack {
                            Button(action: {
                                
                            }) {
                                Text(book.authorName ?? "")
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .foregroundColor(Color(.white))
                                Image(systemName: "chevron.right")
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .foregroundColor(Color(.white))
                            }
                            .font(.callout)
                        }
                        
                   
//                        if let authorName = book.audioBookDetails?.audioAuthor, book.bookType == .audio {
//                            HStack {
//                                Text("Is reading")
//                                    .font(.callout)
//                                    .foregroundColor(.white)
//                                Button(action: {
//                                    
//                                }) {
//                                    HStack {
//                                        Text(authorName)
//                                        Image(systemName: "chevron.right")
//                                    }
//                                    .foregroundColor(Color("MainColor"))
//                                    .foregroundColor(.white)
//                                }
//                                .font(.callout)
//                            }
//                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    BookDetailsHeader(book: MockData.getBook())
//}
