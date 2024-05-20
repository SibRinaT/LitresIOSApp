//
//  CardNumbersView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct CardNumbersView: View {
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("Добавление новой карты")
                        .font(.custom("AmericanTypewriter", size: 24))
                        .bold()
                        .foregroundColor(Color(.white))
                    Spacer()
                }
                
                
            }
        }
    }
}

#Preview {
    CardNumbersView()
}
