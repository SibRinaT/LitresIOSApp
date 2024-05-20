//
//  SubscriptionView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct SubscriptionView: View {
    @Environment(\.authService) var authService
    @Binding var isSheetPresented: Bool
    @State var showPayView = false
    
    var subEnabled: Bool {
        authService.user?.isSubscriptionEnabled ?? false
    }
    
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                Text("Подписка")
                    .font(.custom("AmericanTypewriter", size: 48))
                    .foregroundColor(.white)
                VStack {
                    
                    Rectangle()
                        .frame(width: 280, height: 57)
                        .cornerRadius(14)
                        .foregroundColor(subEnabled ? Color("SecondaryColor") : Color("MainColor"))
                        .overlay(
                            Text("Базовая")
                                .foregroundColor(.white)
                        )
                    
                    Button (action: {
                        showPayView.toggle()
                    }) {
                        Capsule()
                            .fill(subEnabled ? Color("MainColor"): Color("SecondaryColor"))
                            .frame(width: 280, height: 57)
                            .opacity(0.5)
                            .overlay {
                                Text(subEnabled ? "Подписка активирована": "Расширенная на месяц")
                                    .foregroundColor(.white)
                            }
                    }
                    .disabled(subEnabled)
                }
            }
        }
        .fullScreenCover(isPresented: $showPayView) {
            SubsBuyView()
        }
    }
    
}

#Preview {
    SubscriptionView(isSheetPresented: .constant(true))
}
