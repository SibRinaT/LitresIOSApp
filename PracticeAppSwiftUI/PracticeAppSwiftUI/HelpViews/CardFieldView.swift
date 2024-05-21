//
//  CardFieldView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 21.05.2024.
//
import SwiftUI

struct CardFieldView: View {
    let title: String = "Номер карты"
    let placeholder: String = "1234 5678 9012 3456"
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color.white)
                .font(.custom("AmericanTypewriter", size: 20))
            
            ZStack(alignment: .leading) {
                Capsule()
                    .stroke(Color.white, lineWidth: 1)
                    .background(Capsule().fill(Color("MainColor")))
                    .frame(height: 50)
                
                TextField(placeholder, text: $text)
                    .onChange(of: text, {
                        text = formatCardNumber(text)
                    })
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.black)
                .font(.custom("AmericanTypewriter", size: 16))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .autocapitalization(.none)
                .keyboardType(.numberPad)
                .frame(width: 302, height: 40)
            }
        }
        .padding(.bottom)
    }
    
    private func formatCardNumber(_ number: String) -> String {
        // Удалить все, кроме цифр
        let digits = number.filter { "0123456789".contains($0) }
        var result = ""
        for (index, char) in digits.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            if result.count < 20 {
                result.append(char)
            }
        }
        return result
    }
}

struct CardFieldView_Previews: PreviewProvider {
    @State static var cardNumber = ""
    
    static var previews: some View {
        CardFieldView(text: $cardNumber)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
