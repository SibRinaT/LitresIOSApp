//
//  AddNewFeedbackView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct AddNewFeedbackView: View {
    @State private var reviewText = ""
    @State private var rating = 0

    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(Color("SecondaryColor"))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 50)
                    .overlay(
                        VStack {
                            Text("Новый отзыв")
                                .foregroundColor(.white)
                                .font(.custom("AmericanTypewriter", size: 24))
                            VStack {
                                HStack {
                                    Text("Название книги: ")
                                    Text("1984") // code for name book
                                }
                                .font(.custom("AmericanTypewriter", size: 18))
                                .foregroundColor(.white)
                                HStack {
                                    Text("Автор книги: ")
                                    Text("Дж. Оруэлл") // code for author book
                                }
                                .font(.custom("AmericanTypewriter", size: 18))
                                .foregroundColor(.white)
                                HStack {
                                    Text("Оценка: ")
                                        .font(.custom("AmericanTypewriter", size: 18))
                                        .foregroundColor(.white)
                                    
                                    ForEach(1..<6) { index in
                                                        Image(systemName: index <= rating ? "star.fill" : "star")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 15, height: 15)
                                                            .foregroundColor(.yellow)
                                                            .onTapGesture {
                                                                rating = index
                                                            }
                                                    }
                                }
                                TextEditor(text: $reviewText)
                                    .cornerRadius(14)
                                    .frame(height: 180)
                                    .padding()
                                    .padding()
                                    .padding(.horizontal, 30)
                                
                                if reviewText.count < 20 {
                                    Text("Минимальная длина 20 символов!")
                                        .foregroundColor(.white)
                                        .padding()

                                } else {
                                    Text("")
                                        .padding()
                                }
                                if rating == 0 {
                                               Text("Пожалуйста, выставьте рейтинг")
                                                   .foregroundColor(.white)
                                                   .padding()
                                           } else {
                                               Text("")
                                                   .padding()
                                           }
                        
                                
                                Text("\(reviewText.count)/150 символов")
                                    .foregroundColor(reviewText.count > 150 ? .red : .white)
                                              .padding(.bottom, 20)
                                
                                Button(action: {}) {
                                    Rectangle()
                                        .cornerRadius(14)
                                        .frame(width: 200 ,height: 70)
                                        .foregroundColor(reviewText.count < 20 ? .black : .gray)
                                        .overlay(
                                            Text("Отправить")
                                                .font(.custom("AmericanTypewriter", size: 18))
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                        }
                    )
                
            }
        }
    }
}

#Preview {
    AddNewFeedbackView()
}
