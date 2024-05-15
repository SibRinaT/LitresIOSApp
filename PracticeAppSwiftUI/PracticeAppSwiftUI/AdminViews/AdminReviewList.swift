//
//  AdminReviewList.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 14.05.2024.
//

import SwiftUI

struct AdminReviewList: View {
    @State var reviews = [Review]()
    @State private var book: Book?
    @State private var review: Review?
    
    var shouldOpenReview: Binding<Bool> {
        Binding {
            book != nil
        } set: { _ in
            book = nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(reviews) { review in
                    Button {
                        self.review = review
                        getBookBy(id: review.bookId)
                    } label: {
                        Text(review.reviewText)
                    }
                    .buttonStyle(.plain)
                }
                .onDelete(perform: deleteBooks)
            }
        }
        .navigationTitle("Reviews")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
        }
        .task {
            do {
                reviews = try await Store.shared.getReviews()
            } catch {
                print(error)
            }
        }
        .navigationDestination(isPresented: shouldOpenReview) {
            if let book, let review {
                AddNewFeedbackView(book: book, viewType: .edit(review: review))
            }
            
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        Task {
            for i in offsets {
                try await Store.shared.delete(review: reviews[i])
            }
        }
    }
    
    private func getBookBy(id: String) {
        Task {
            do {
                self.book = try await Store.shared.getBook(by: id)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AdminReviewList()
}

