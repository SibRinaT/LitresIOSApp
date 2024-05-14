//
//  AddNewFeedbackView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct AddNewFeedbackView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var reviewText = ""
    @State private var rating = 0
    var book: Book
    
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
                                    Text(book.name)
                                }
                                .font(.custom("AmericanTypewriter", size: 24))
                                .foregroundColor(.white)
                                HStack {
                                    Text(book.authorName ?? "")
                                }
                                .font(.custom("AmericanTypewriter", size: 24))
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
                                    .padding(.bottom, -50)
                                
                                if reviewText.count < 20 {
                                    Text("Минимальная длина 20 символов!")
                                        .foregroundColor(.white)
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .padding()
                                        .padding(.bottom, -30)
                                    
                                } else {
                                    Text("")
                                        .padding()
                                }
                                
                                if rating == 0 {
                                    Text("Пожалуйста, выставьте рейтинг")
                                        .foregroundColor(.white)
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .padding()
                                } else {
                                    Text("")
                                        .padding()
                                }
                                
                                Text("\(reviewText.count)/150 символов")
                                    .foregroundColor(reviewText.count > 150 ? .red : .white)
                                    .padding(.bottom, 20)
                                
                                Button(action: {
                                    sendReview()
                                }) {
                                    Rectangle()
                                        .cornerRadius(14)
                                        .frame(width: 200 ,height: 70)
                                        .foregroundColor(reviewText.count < 20 ? .black : .gray)
                                        .foregroundColor(rating == 0 ? .black : .gray)
                                    
                                        .overlay(
                                            Text("Отправить")
                                                .font(.custom("AmericanTypewriter", size: 18))
                                                .foregroundColor(.white)
                                        )
                                }
                                .disabled(rating == 0 || reviewText.count < 20)
                            }
                        }
                    )
            }
        }
    }
    
    private func sendReview() {
        Task {
            do {
                let user = try await AuthService.shared.fetchUserInfo()
                let review = Review(bookId: book.id,
                                    reviewText: reviewText,
                                    userName: user?.name ?? "Anonym",
                                    rating: rating)
                try Store.shared.add(review: review)
                dismissSelf()
            } catch {
                print(error)
            }
        }
    }
    
    private func dismissSelf() {
        DispatchQueue.main.async {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    AddNewFeedbackView()
//}
