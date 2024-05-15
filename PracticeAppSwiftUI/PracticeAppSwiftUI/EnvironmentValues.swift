//
//  EnvironmentValues.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 15.05.2024.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var authService: AuthService {
        get { self[AuthServiceKey.self] }
        set { self[AuthServiceKey.self] = newValue }
    }
}
