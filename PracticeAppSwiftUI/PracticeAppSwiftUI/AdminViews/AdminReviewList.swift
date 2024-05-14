//
//  AdminReviewList.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 14.05.2024.
//

import SwiftUI

struct AdminReviewList: View {
    @State var reviews = [Review]()
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(reviews) { review in
                    HStack {
                        Text(review.reviewText)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
        }
        .navigationTitle("Books")
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
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        Task {
            for i in offsets {
                try await Store.shared.delete(review: reviews[i])
            }
        }

    }
}

#Preview {
    AdminReviewList()
}

