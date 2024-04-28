//
//  InputFieldView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 28.04.2024.
//

import SwiftUI

struct InputFieldView: View {
    let title: String
    let placeholder: String
    @State var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.white))
                .font(.custom("AmericanTypewriter", size: 20))
            ZStack {
                Group {
                    Capsule()
                        .stroke(Color(.black), lineWidth: 1) //black for test stroke
                        .background(Color.clear)
                        .frame(width: 302, height: 40)
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color(.white))
                        .font(.custom("AmericanTypewriter", size: 16))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(width: 302, height: 40)
                        .foregroundColor(Color(.white))
                }
            }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.bottom)
    }
}

#Preview {
    InputFieldView(title: "Email",
                   placeholder: "Book@gmail.com", text: ""
                )
}