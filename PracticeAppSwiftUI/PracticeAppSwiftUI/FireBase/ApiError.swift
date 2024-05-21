//
//  ApiError.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import Foundation

enum ApiError: LocalizedError {
    case custom(text: String)
    
    var errorDescription: String? {
        switch self {
        case .custom(let text):
            return text
        }
    }
}

enum UploadError: LocalizedError {
    case custom(text: String)
    var errorDescription: String? {
        switch self {
        case .custom(let text):
            return text
        }
    }
}
