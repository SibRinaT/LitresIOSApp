import SwiftUI

struct SubsBuyView: View {
    @State var showCardView = false
    //    @State private var error: UploadError?
    //    @State private var isLoading = false
    
    //    var isShowingError: Binding<Bool> {
    //        Binding {
    //            error != nil
    //        } set: { _ in
    //            error = nil
    //        }
    //    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackColor")
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Text("Вы подключаете")
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
                            .overlay(
                                VStack {
                                    Image("bookIconSub")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    Text("Расширенная")
                                        .foregroundColor(Color(.white))
                                        .font(.custom("AmericanTypewriter", size: 28))
                                        .multilineTextAlignment(.center)
                                    Text("150 руб в месяц")
                                        .foregroundColor(Color(.white))
                                        .font(.custom("AmericanTypewriter", size: 20))
                                        .multilineTextAlignment(.center)
                                }
                            )
                        
                        Rectangle()
                            .foregroundColor(Color("SecondaryColor"))
                            .frame(height: 100)
                            .cornerRadius(16)
                            .overlay(
                                VStack {
                                    Text("Следующее списание 149 р. - 20 мая")
                                        .foregroundColor(Color(.white))
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .multilineTextAlignment(.center)
                                }
                            )
                        
                        Rectangle()
                            .foregroundColor(Color("SecondaryColor"))
                            .frame(height: 100)
                            .cornerRadius(16)
                            .overlay(
                                VStack {
                                    Text("Нажимая кнопку, вы принимаете Условия подписки и Условия опции.")
                                        .font(.custom("AmericanTypewriter", size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color("InactiveColor"))
                                    
                                }
                            )
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
                
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(Color("SecondaryColor"))
                        .frame(height: 150)
                        .ignoresSafeArea(.all)
                        .overlay(
                            VStack {
                                HStack {
                                    Text("Сейчас вы платите - 149руб")
                                        .foregroundColor(Color(.white))
                                        .font(.custom("AmericanTypewriter", size: 18))
                                    Spacer()
                                }
                                
                                Rectangle()
                                    .cornerRadius(16)
                                    .foregroundColor(Color("InactiveColor"))
                                
                            }
                                .padding(.horizontal)
                        )
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .frame(height: 150)
                    .ignoresSafeArea(.all)
                    .overlay(
                        VStack {
                            HStack {
                                Text("Сейчас вы платите - 149руб")
                                    .foregroundColor(Color(.white))
                                    .font(.custom("AmericanTypewriter", size: 18))
                                Spacer()
                            }
                            
                            Button (action: {
                                showCardView.toggle()
                            }) {
                                Rectangle()
                                    .fill(Color("InactiveColor"))
                                    .cornerRadius(16)
                                    .frame(width: 280, height: 57)
                                    .overlay {
                                        Text("Подключить")
                                            .foregroundColor(.white)
                                            .font(.custom("AmericanTypewriter", size: 24))
                                            .bold()
                                            .multilineTextAlignment(.center)
                                    }
                                
                            }
                            //                            .disabled(isLoading)
                        }
                            .padding(.horizontal)
                    )
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .fullScreenCover(isPresented: $showCardView) {
            AddCardView()
        }
        //        .alert(isPresented: isShowingError, error: error) { _ in
        //        } message: { error in
        //            Text(error.errorDescription ?? "")
        //        }
    }
    
    //    private func enableSub() {
    //        isLoading = true
    //        Task {
    //            do {
    //                try await authService.enableSubscription()
    //                hideIndicator()
    //            } catch {
    //                self.error = UploadError.custom(text: error.localizedDescription)
    //                hideIndicator()
    //            }
    //        }
    //    }
    
    //    private func hideIndicator() {
    //        DispatchQueue.main.async {
    //            isLoading = false
    //        }
    //    }
}

#Preview {
    SubsBuyView()
}
