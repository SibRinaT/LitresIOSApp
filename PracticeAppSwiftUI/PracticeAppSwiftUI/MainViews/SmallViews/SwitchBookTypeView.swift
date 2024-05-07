//
//  SwitchBookTypeView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//


import Foundation
import SwiftUI

struct SwitchBookTypeView: View {
    var book: Book1
    
    var body: some View {
        NavigationLink(destination: BookDetails(book: book)) {
            HStack() {
                Image(systemName: "book")
                    .font(.title2)
                switch BookType(rawValue: book.bookType) {
                case .audio:
                    Text("To the audio\nversion")
                case .text:
                    Text("To the text\nversion")
                case .none:
                    Text("")
                }
            }
        }
        .tint(.orange)
        .buttonStyle(.borderedProminent)
    }
}

//#Preview {
//    SwitchBookTypeView(book: MockData.getBook())
//}
