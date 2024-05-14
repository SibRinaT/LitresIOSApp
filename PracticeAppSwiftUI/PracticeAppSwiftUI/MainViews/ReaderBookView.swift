//
//  ReaderBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 14.05.2024.
//

import SwiftUI

struct ReaderBookView: View {
    var body: some View {
        ScrollView {
            TextEditor (text: BookDetailsBody ){
                
            }
        }
    }
}

#Preview {
    ReaderBookView()
}
