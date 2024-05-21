//
//  CardNumbersView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct CardNumbersView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Добавление новой карты")
                .font(.custom("AmericanTypewriter", size: 28))
                .bold()
                .foregroundColor(Color(.white))
            Spacer()
            CardFieldView(text: $text)
            Spacer()
            
            Button(action: {
                
            }) {
                Rectangle()
                    .foregroundColor(Color("InactiveColor"))
                    .frame(height: 80)
                    .cornerRadius(16)
                    .overlay(
                        HStack {
                            Text("Добавить")
                                .foregroundColor(Color(.white))
                                .font(.custom("AmericanTypewriter", size: 20))
                                .multilineTextAlignment(.center)
                                .bold()
                        }
                            .padding(.horizontal)
                    )
            }
        }
        .padding(.horizontal)
        .background(Color("BackColor"))
    }
}

#Preview {
    CardNumbersView()
}
