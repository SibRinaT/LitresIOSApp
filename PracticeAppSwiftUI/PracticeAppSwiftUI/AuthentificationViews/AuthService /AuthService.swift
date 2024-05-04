//
//  AuthServicre.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 04.05.2024.
//

import SwiftUI
import Firebase

final class AuthService {
    @State var email = ""
    @State var password = "" 
    
    private let auth = Auth.auth()
    
    func register() {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                print(result)
            }
            if error != nil {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    
}
