//
//  ReaderBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 14.05.2024.
//

import SwiftUI

struct ReaderBookView: View {
    @Binding var isSheetPresented: Bool
    @State var bookText: String
    
    var body: some View {
        ScrollView {
            TextEditor (text: $bookText)
        }
    }
}

