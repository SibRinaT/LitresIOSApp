//
//  SubscriptionView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 07.05.2024.
//

import SwiftUI

struct SubscriptionView: View {
    let authService = AuthService.shared
    @State private var selectedSubscription: SubscriptionType?
    @Binding var isSheetPresented: Bool

    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                Text("Подписка")
                    .font(.custom("AmericanTypewriter", size: 48))
                    .foregroundColor(.white)
                VStack {
                    Button (action: {
                        selectedSubscription = .basic
                    }) {
                        if selectedSubscription == .basic {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("MainColor"))
                                .overlay(
                                    Text("Базовая")
                                        .foregroundColor(.white)
                                )
                        } else {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("SecondaryColor"))
                                .overlay(
                                    Text("Базовая")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    
                    Button (action: {
                        selectedSubscription = .month
                        Task {
                            do {
                                let enableSubscription = try await authService.enableSubscription()
                                print("subscription: ", enableSubscription)
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        if selectedSubscription == .month {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("MainColor"))
                                .overlay(
                                        Text("Расширенная на месяц")
                                            .foregroundColor(.white)
                                )
                        } else {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("SecondaryColor"))
                                .overlay(
                                        Text("Расширенная на месяц")
                                            .foregroundColor(.white)
                                        )
                        }
                    }
                    
                    Button (action: {
                        selectedSubscription = .year

                        Task {
                            do {
                                let enableSubscription = try await authService.enableSubscription()
                                print("subscription: ", enableSubscription)
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        if selectedSubscription == .year {
                            Rectangle()
                                .frame(width: 280, height: 57)
                                .cornerRadius(14)
                                .foregroundColor(Color("MainColor"))
                                .overlay(
                                    Text("Расширенная на год")
                                        .foregroundColor(.white)
                                )
                        } else {
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
}

enum SubscriptionType {
    case basic
    case month
    case year
}

#Preview {
    SubscriptionView()
}
