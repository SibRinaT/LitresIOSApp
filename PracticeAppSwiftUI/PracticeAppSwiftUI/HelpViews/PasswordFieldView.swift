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
       @State var isSecured = false
       @State private var isPasswordHidden = true
       @State var text: String

       
       var body: some View {
           VStack(alignment: .leading) {
               Text(title)
                   .foregroundColor(Color("TextColor"))
                   .font(.custom("", size: 20))
               ZStack(alignment: .trailing) {
                   Group {
                       Capsule()
                           .stroke(Color("PrimaryColor"), lineWidth: 1)
                           .background(Color.clear)
                           .frame(width: 302, height: 40)
                       if isSecured && isPasswordHidden {
                           SecureField(placeholder, text: $text)
                               .foregroundColor(Color("InactiveColor"))
                               .font(.custom("MontserratAlternates", size: 16)) // need to fix a font
                               .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                               .textFieldStyle(PlainTextFieldStyle())
                               .frame(width: 302, height: 40)
                       } else {
                           TextField(placeholder, text:  $text)
                               .foregroundColor(Color("InactiveColor"))
                               .font(.custom("MontserratAlternates", size: 16)) // need to fix a font
                               .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                               .textFieldStyle(PlainTextFieldStyle())
                               .frame(width: 302, height: 40)
                       }
                   }
                   Button(action: {
                       isPasswordHidden.toggle()
                   }) {
                       Image(self.isPasswordHidden ? "EyeSlashIcon" : "EyeIcon")
                           .accentColor(Color("PrimaryColor"))
                   }
                   .padding(.trailing, 5)
                   .opacity(isSecured ? 1: 0)
               }
           }
           .padding(.bottom)
       }
   }
#Preview {
    PasswordFieldView(title: "Пароль",
                   placeholder: "*******",
                           isSecured: true, text: ""
                           )
}
