//
//  SubscriptionView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                Text("Подписка")
                    .font(.custom("AmericanTypewriter", size: 48))
                    .foregroundColor(.white)
                VStack {
                    Button (action: {}) {
                        Rectangle()
                            .frame(width: 280, height: 57)
                            .cornerRadius(14)
                            .foregroundColor(Color("SecondaryColor"))
                            .overlay(
                                Text("Базовая")
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Button (action: {}) {
                        Rectangle()
                            .frame(width: 280, height: 57)
                            .cornerRadius(14)
                            .foregroundColor(Color("SecondaryColor"))
                            .overlay(
                                    Text("Расщиренная на месяц")
                                        .foregroundColor(.white)
                            )
                    }
                    
                    Button (action: {}) {
                        Rectangle()
                            .frame(width: 280, height: 57)
                            .cornerRadius(14)
                            .foregroundColor(Color("SecondaryColor"))
                            .overlay(
                                Text("Расширенная на год")
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    SubscriptionView()
}
