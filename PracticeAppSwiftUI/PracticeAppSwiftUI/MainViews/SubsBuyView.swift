import SwiftUI

struct SubsBuyView: View {
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
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .overlay (
                                        Text("Подключить")
                                            .foregroundColor(Color(.white))
                                            .font(.custom("AmericanTypewriter", size: 24))
                                            .bold()
                                            .multilineTextAlignment(.center)
                                    )
                            }
                                .padding(.horizontal)
                        )
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    SubsBuyView()
}
