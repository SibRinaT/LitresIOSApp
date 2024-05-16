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
                        .font(.custom("AmericanTypewriter", size: 20))
                        .foregroundColor(.white)
                        .bold()
                    Text("\(review.reviewDate.formatted(date: .long, time: .omitted))")
                        .foregroundColor(.white)
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
                .foregroundColor(.white)
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.green)
                    Text("2")
                        .foregroundColor(.green)
                }
                Button(action: {
                }) {
                    Image(systemName: "hand.thumbsdown")
                        .foregroundColor(.red)
                    Text("1")
                        .foregroundColor(.red)
                }
                Button(action: {
                }) {
                    Image("moreImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }
            }
            .foregroundColor(.white)

        }
        .background(Color("BackColor").ignoresSafeArea(.all))
    }
}

#Preview {
    ScrollView {
        
    }
}
