//
//  AddCardView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct AddCardView: View {
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("Оплата картой")
                        .font(.custom("AmericanTypewriter", size: 24))
                        .bold()
                        .foregroundColor(Color(.white))
                    Spacer()
                }
                .padding()
                
                VStack {
                    Rectangle()
                        .frame(height: 250)
                        .cornerRadius(16)
                        .foregroundColor(Color("SecondaryColor"))
                        .opacity(0.75)
                        .overlay(
                            VStack {
                                Rectangle()
                                    .foregroundColor(Color("SecondaryColor"))
                                    .frame(height: 80)
                                    .cornerRadius(16)
                                    .overlay(
                                        HStack {
                                            Image("cardIcon")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Text("8934*********")
                                                .foregroundColor(Color(.white))
                                                .font(.custom("AmericanTypewriter", size: 16))
                                                .multilineTextAlignment(.center)
                                            Spacer()
                                        }
                                            .padding(.horizontal)
                                    )
                                    .padding(.horizontal)
                                
                                Rectangle()
                                    .foregroundColor(Color("SecondaryColor"))
                                    .frame(height: 80)
                                    .cornerRadius(16)
                                    .overlay(
                                        HStack {
                                            Image("cardIcon")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Text("Добавить карту")
                                                .foregroundColor(Color(.white))
                                                .font(.custom("AmericanTypewriter", size: 16))
                                                .multilineTextAlignment(.center)
                                            Spacer()
                                        }
                                            .padding(.horizontal)
                                    )
                                    .padding(.horizontal)
                                
                               
                            }
                        )
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(Color("InactiveColor"))
                        .frame(height: 80)
                        .cornerRadius(16)
                        .overlay(
                            HStack {
                                Text("Оплатить")
                                    .foregroundColor(Color(.white))
                                    .font(.custom("AmericanTypewriter", size: 20))
                                    .multilineTextAlignment(.center)
                                    .bold()
                            }
                                .padding(.horizontal)
                        )
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AddCardView()
}
