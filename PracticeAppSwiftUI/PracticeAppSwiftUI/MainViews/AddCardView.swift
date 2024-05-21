//
//  AddCardView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 20.05.2024.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.authService) var authService
    @Environment(\.dismiss) private var dismiss
    @State var cards = BankCardStore.getCards()
    @State var selectedCard: BankCard?
    @State private var error: UploadError?
    @State private var isLoading = false
    @State private var isShowingSuccess = false
    @State var addCardView = false

    
    var isShowingError: Binding<Bool> {
        Binding {
            error != nil
        } set: { _ in
            error = nil
        }
    }
    
    
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
                    if !cards.isEmpty {
                        List(cards) { card in
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
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .background(Color("SecondaryColor"))
                            .cornerRadiusWithBorder(radius: 16, borderLineWidth: card == selectedCard ? 2 : 0)
                            .onTapGesture {
                                selectedCard = card
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    
                    
                    Button(action: {
                        addCardView.toggle()
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
                    .padding()
                }
                .background(Color("SecondaryColor").opacity(0.55))
                .cornerRadius(16)
                
                Spacer()
                
                Button {
                    enableSub()
                } label: {
                    if isLoading {
                        Rectangle()
                            .foregroundColor(Color("SecondaryColor"))
                            .frame(height: 80)
                            .cornerRadius(16)
                            .overlay(
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                            )
                    } else {
                        Rectangle()
                            .foregroundColor(selectedCard == nil ? Color("SecondaryColor") : Color("InactiveColor"))
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
                
                    
                }
//                .disabled(selectedCard == nil || isLoading)
            }
            
        }
        .padding(.horizontal)
        .background(Color("BackColor"))
        .alert(isPresented: isShowingError, error: error) { _ in
        } message: { error in
            Text(error.errorDescription ?? "")
        }
        .alert("Успешно!", isPresented: $isShowingSuccess) {
            Button("Ok") {
                dismiss()
            }
        } message: {
            Text("Оплата прошла успешно. Ваша подписка активирована")
        }
        .fullScreenCover(isPresented: $addCardView) {
            CardNumbersView()
        }
    }
    
    private func enableSub() {
        isLoading = true
        Task {
            do {
                try await authService.enableSubscription()
                hideIndicator()
                isShowingSuccess = true
            } catch  {
                self.error = UploadError.custom(text: error.localizedDescription)
                hideIndicator()
            }
        }
    }
    
    private func hideIndicator() {
        DispatchQueue.main.async {
            isLoading = false
        }
    }
}

#Preview {
    AddCardView(cards:
                    [
                        BankCard(number: "2345678341625", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                        BankCard(number: "234567845678", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                        BankCard(number: "234567845674", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                        BankCard(number: "234567845673", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                        BankCard(number: "234567845672", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                        BankCard(number: "234567845671", cvv: "123", name: "Jhon Doe", expirationDate: "12/24"),
                    ]
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
