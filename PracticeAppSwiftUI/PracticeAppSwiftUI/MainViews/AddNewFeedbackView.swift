//
//  AddNewFeedbackView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct AddNewFeedbackView: View {
    enum ViewType {
        case add
        case edit(review: Review)
        
        var title: String {
            switch self {
            case .add:
                "Новый отзыв"
            case .edit:
                "Изменить отзыв"
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.authService) var authService
    
    @State private var reviewText = ""
    @State private var rating = 0
    let book: Book
    let viewType: ViewType
    
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
                            Text(viewType.title)
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
        .onAppear {
            switch viewType {
            case .add:
                break
            case .edit(let review):
                reviewText = review.reviewText
                rating = review.rating
            }
        }
    }
    
    private func sendReview() {
        Task {
            do {
                let userName = authService.user?.name ?? "Anonym"
                switch viewType {
                case .add:
                    let review = buildReview(userName: userName)
                    try Store.shared.add(review: review)
                case .edit(let oldReview):
                    guard let firestoreId = oldReview.firestoreId else { return }
                    try await Store.shared.update(reviewId: firestoreId,
                                                  text: reviewText,
                                                  rating: rating)
                }
                dismissSelf()
            } catch {
                print(error)
            }
        }
    }
    
    private func buildReview(userName: String) -> Review {
        var review = Review(id: UUID().uuidString,
                            bookId: book.id,
                            reviewText: reviewText,
                            userName: userName,
                            rating: rating,
                            reviewDate: Date())
        return review
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
