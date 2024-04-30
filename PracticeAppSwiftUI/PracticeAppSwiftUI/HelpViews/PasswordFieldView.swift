//
//  PasswordFieldView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 29.04.2024.
//

import SwiftUI

struct PasswordFieldView: View {
    let title: String
       let placeholder: String
       @State private var isPasswordHidden = true
       @State var text: String

       var body: some View {
           VStack(alignment: .leading) {
               Text(title)
                   .foregroundColor(Color(.white))
                   .font(.custom("AmericanTypewriter", size: 20))
               ZStack(alignment: .trailing) {
                   Group {
                       Capsule()
                           .stroke(Color(.black), lineWidth: 1) // black for test
                           .background(Color.clear)
                           .frame(width: 302, height: 40)
                       if isPasswordHidden {
                           SecureField(placeholder, text: $text)
                               .foregroundColor(Color(.white))
                               .font(.custom("AmericanTypewriter", size: 16))
                               .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                               .textFieldStyle(PlainTextFieldStyle())
                               .frame(width: 302, height: 40)
                       } else {
                           TextField(placeholder, text:  $text)
                               .foregroundColor(Color(.white))
                               .font(.custom("AmericanTypewriter", size: 16)) 
                               .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                               .textFieldStyle(PlainTextFieldStyle())
                               .frame(width: 302, height: 40)
                       }
                   }
                   Button(action: {
                       isPasswordHidden.toggle()
                   }) {
                       Image(self.isPasswordHidden ? "eyeInactive" : "eyeActive")
                           .accentColor(Color("MainColor"))
                   }
                   .padding(.trailing, 5)
               }
           }
           .padding(.bottom)
       }
   }
#Preview {
    PasswordFieldView(title: "Пароль",
                   placeholder: "*******",
                    text: ""
                    )
}
