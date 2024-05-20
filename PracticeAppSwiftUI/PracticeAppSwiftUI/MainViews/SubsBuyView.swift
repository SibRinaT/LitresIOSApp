//
//  SubsBuyView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct SubsBuyView: View {
    var body: some View {
        VStack {
            Text("Вы подключаете")
                .font(.custom("AmericanTypewriter", size: 24))

            VStack {
                Rectangle()
                    .overlay(
                        VStack {
                            Text("Расширенная")
                                .font(.custom("AmericanTypewriter", size: 48))
                                .multilineTextAlignment(.center)
                            Text("150 руб в месяц")
                                .font(.custom("AmericanTypewriter", size: 24))
                                .multilineTextAlignment(.center)
                        }
                    )
            }
        }
    }
}

#Preview {
    SubsBuyView()
}
