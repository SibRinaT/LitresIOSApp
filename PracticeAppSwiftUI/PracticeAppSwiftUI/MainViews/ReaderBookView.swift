//
//  ReaderBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 14.05.2024.
//

import SwiftUI

struct ReaderBookView: View {

    @Binding var isSheetPresented: Bool
    @State var book: Book
    @State var bookText: String
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    TextEditor (text: $bookText)
                }
            }
            .navigationTitle(book.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Закрыть") {
                        isSheetPresented = false
                    }
                }
            }
        }
    }
    

}

