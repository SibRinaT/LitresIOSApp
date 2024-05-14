//
//  BookReview.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

struct BookReview: View {
    var review: Review
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
//                AsyncImage(url: URL(string: review.userImageURL)!)
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(50)
                VStack (alignment: .leading) {
                    Text(review.userName)
                        .bold()
                    Text("\(review.reviewDate.formatted(date: .long, time: .omitted))")
                }
                Spacer()
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: "star")
                            .foregroundStyle(.orange)
                            .symbolVariant(review.rating > index ? .fill : .none)
                    }
                }
            }
            Text(review.reviewText)
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "hand.thumbsup")
                    Text("2")
                }
                Button(action: {
                }) {
                    Image(systemName: "hand.thumbsdown")
                    Text("1")
                }
                Button(action: {
                }) {
                    Image("moreImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }

            }
        }
        .background(Color("BackColor").ignoresSafeArea(.all))
    }
}

#Preview {
    ScrollView {
        
    }
}
