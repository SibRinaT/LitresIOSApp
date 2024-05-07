//
//  AddNewFeedbackView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct AddNewFeedbackView: View {
    @State private var reviewText = ""
    
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
                                    
                                    //code for rating
                                }
                                TextEditor(text: $reviewText)
                                    .cornerRadius(14) // закругляем углы
                                    .frame(height: 180) // минимальная высота для большего текста
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
                        
                                
                                Text("\(reviewText.count)/150 символов")
                                    .foregroundColor(reviewText.count > 150 ? .red : .white) // изменяем цвет текста, если превышен лимит символов
                                              .padding(.bottom, 20)
                                
                                Button(action: {}) {
                                    Rectangle()
                                        .cornerRadius(14)
                                        .frame(width: 200 ,height: 70)
                                        .foregroundColor(reviewText.count < 20 ? .black : .gray) // изменяем цвет текста, если превышен лимит символов
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
