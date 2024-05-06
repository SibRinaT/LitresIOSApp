//
//  OTPVerifitactionView .swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 01.05.2024.
//

import SwiftUI

struct OTPVerificationView: View {
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }
    
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = "" {
        didSet {
            isImageColored2 = !pinTwo.isEmpty
        }
    }
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State private var isImageColored1 = false
    @State private var isImageColored2 = false
    @State private var isImageColored3 = false
    @State private var isImageColored4 = false
    
    var completionHandler: ((String) -> ())?

    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Image(isImageColored1 ? "AuthInputWhite" : "AuthInputBlack")
                        .overlay(
                            TextField("", text: $pinOne)
                                .background(Color(isImageColored1 ? "WhiteColor" : "SecondaryColor"))
                                .modifier(OtpModifer(pin:$pinOne))
                                .onChange(of:pinOne) { newVal in
                                    if (newVal.count == 1) {
                                        pinFocusState = .pinTwo
                                        isImageColored1 = true
                                    } else if pinFour.isEmpty {
                                        pinFocusState = .pinOne
                                        isImageColored1 = false
                                    }
                                    sendPin()
                                }
                                .focused($pinFocusState, equals: .pinOne)
                        )
                    
                    Image(isImageColored2 ? "AuthInputWhite" : "AuthInputBlack")
                        .overlay(
                            TextField("", text: $pinTwo)
                                .background(Color(isImageColored2 ? "WhiteColor" : "SecondaryColor"))
                                .modifier(OtpModifer(pin: $pinTwo))
                                .onChange(of: pinTwo) { _ in
                                    isImageColored2 = !pinTwo.isEmpty
                                    if pinTwo.isEmpty {
                                        pinFocusState = .pinOne // Переключаемся на предыдущее поле, если текущее пустое
                                    } else if (pinTwo.count == 1) {
                                        pinFocusState = .pinThree
                                    }
                                    sendPin()
                                }
                                .focused($pinFocusState, equals: .pinTwo)
                            )
                    Image(isImageColored3 ? "AuthInputWhite" : "AuthInputBlack")
                        .overlay(
                            TextField("", text: $pinThree)
                                .background(Color(isImageColored3 ? "WhiteColor" : "SecondaryColor"))
                                .modifier(OtpModifer(pin: $pinThree))
                                .onChange(of: pinThree) { _ in
                                    isImageColored3 = !pinThree.isEmpty
                                    if pinThree.isEmpty {
                                        pinFocusState = .pinTwo // Переключаемся на предыдущее поле, если текущее пустое
                                    } else if (pinThree.count == 1) {
                                        pinFocusState = .pinFour
                                    }
                                    sendPin()
                                }
                                .focused($pinFocusState, equals: .pinThree)
                        )
                    
                    Image(isImageColored4 ? "AuthInputWhite" : "AuthInputBlack")
                        .overlay(
                            TextField("", text: $pinFour)
                                .background(Color(isImageColored4 ? "WhiteColor" : "SecondaryColor"))
                                .modifier(OtpModifer(pin: $pinFour))
                                .onChange(of: pinFour) { _ in
                                    isImageColored4 = !pinFour.isEmpty
                                    if pinFour.isEmpty {
                                        pinFocusState = .pinThree // Переключаемся на предыдущее поле, если текущее пустое
                                    }
                                    sendPin()
                                }
                                .focused($pinFocusState, equals: .pinFour)
                        )
                }
            }
        }
    }
    func sendPin() {
        let pin = [pinOne, pinTwo, pinThree, pinFour].joined()
        completionHandler?(pin)
    }
}

#Preview {
    OTPVerificationView()
}
