//
//  ShelfView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct ShelfView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    
    var shelfName: String
    var books: [Book]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(shelfName)
                .multilineTextAlignment(.leading)
                .font(.largeTitle)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(books, id: \.id) { book in
                        NavigationLink(destination: BookDetails(book: book)) {
                            BookView(book: book)
//                                .containerRelativeFrame(.horizontal,
//                                                        count: 1,//sizeClass == .regular ? 2 : 2,
////                                                        span: 2,
//                                                        spacing: 0)
                        }
                    }
                }
//                .scrollTargetLayout()
            }
//            .scrollTargetBehavior(.paging)
//            .safeAreaPadding(.horizontal, 85)
        }
    }
}

#Preview {
    ShelfView(shelfName: "New Releases", books: MockData.getBooks(count: 10))
}
