//
//  AddCardView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct AddCardView: View {
    @State var cards = BankCardStore.getCards()
    @State var selectedCard: BankCard?
    
    var body: some View {
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
                VStack {
                    LazyVStack {
                        ForEach(cards) { card in
                            HStack {
                                Image("cardIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Spacer()
                                Text(card.maskedNumber)
                                    .foregroundColor(Color(.white))
                                    .font(.custom("AmericanTypewriter", size: 16))
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color("SecondaryColor"))
                            .cornerRadiusWithBorder(radius: 16, borderLineWidth: card == selectedCard ? 2 : 0)
                            .onTapGesture {
                                selectedCard = card
                            }
                            
                        }
                    }
                    .padding([.top, .leading, .trailing])
                    
                    Button(action: {
                        
                    }) {
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
                    }
                    .padding([.bottom, .leading, .trailing])
                }
                .background(Color("SecondaryColor").opacity(0.55))
                .cornerRadius(16)
                
                Spacer()
                
                Button {
                    
                } label: {
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
                    
                }
                .disabled(selectedCard == nil)
                .padding(.horizontal)
                
                
            }
            
        }
        .padding(.horizontal)
        .background(Color("BackColor"))
    }
}

#Preview {
    AddCardView(cards:
                    [BankCard(number: "2345678345678", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                     BankCard(number: "234567845678", cvv: "123", name: "Jhon Doe", expirationDate: "12/24")]
    )
}



fileprivate struct ModifierCornerRadiusWithBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat
    var borderColor: Color
    var antialiased: Bool
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius, antialiased: self.antialiased)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
            )
    }
}

extension View {
    func cornerRadiusWithBorder(radius: CGFloat, borderLineWidth: CGFloat = 0, borderColor: Color = .white, antialiased: Bool = true) -> some View {
        modifier(ModifierCornerRadiusWithBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, antialiased: antialiased))
    }
}
