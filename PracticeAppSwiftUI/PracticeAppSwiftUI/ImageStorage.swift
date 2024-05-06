//
//  ImageStorage.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import Foundation
import FirebaseStorage


struct ImageStorage {
    
    enum ImageStorageError: Error {
        case custom(text: String)
    }
    
    static let shared = ImageStorage()
    let storage = Storage.storage()
        
    @discardableResult
    func upload(imageData: Data, name: String) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            
            let storageRef = storage.reference()
            let riversRef = storageRef.child("images/\(name).jpg")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = riversRef.putData(imageData, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                    continuation.resume(throwing: error ?? ImageStorageError.custom(text: "putData error"))
                    return
                }
                continuation.resume(with: .success(name))
            }
        }
    }
    
    func getDownloadUrlFor(imageName: String) async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            let storageRef = storage.reference()
            let riversRef = storageRef.child("images/\(imageName).jpg")
            riversRef.downloadURL { result in
                continuation.resume(with: result)
            }
        }
    }
}
