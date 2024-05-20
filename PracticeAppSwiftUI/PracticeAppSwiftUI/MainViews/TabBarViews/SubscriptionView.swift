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
    @State private var error: UploadError?
    @State private var isLoading = false
    
    var isShowingError: Binding<Bool> {
        Binding {
            error != nil
        } set: { _ in
            error = nil
        }
    }
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
                        enableSub()
                    }) {
                        if isLoading {
                            Capsule()
                                .fill(subEnabled ? Color("MainColor"): Color("SecondaryColor"))
                                .frame(width: 280, height: 57)

                                .overlay {
                                    ProgressView().progressViewStyle(.circular)
                                }
                        } else {
                            Capsule()
                                .fill(subEnabled ? Color("MainColor"): Color("SecondaryColor"))
                                .frame(width: 280, height: 57)
                                .opacity(0.5)
                                .overlay {
                                    Text("Расширенная на месяц")
                                        .foregroundColor(.white)
                                }
                        }
     
                    }
                    .disabled(subEnabled || isLoading)
                }
            }
        }
        .alert(isPresented: isShowingError, error: error) { _ in
        } message: { error in
            Text(error.errorDescription ?? "")
        }
    }
    
    private func enableSub() {
        isLoading = true
        Task {
            do {
                try await authService.enableSubscription()
                hideIndicator()
            } catch {
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
    SubscriptionView(isSheetPresented: .constant(true))
}
