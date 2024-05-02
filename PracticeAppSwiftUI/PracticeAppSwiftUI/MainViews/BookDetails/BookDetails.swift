//
//  BookDetails.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct BookDetails: View {
    var book: Book
    
    var body: some View {
        ScrollView {
            BookDetailsHeader(book: book)
            BookDetailsBody(book: book)
        }
    }
}

#Preview {
    BookDetails(book: MockData.getBook())
}
