//
//  ImageStorage.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import Foundation
import FirebaseStorage


struct ImageStorage {
    
    static let shared = ImageStorage()
    let storage = Storage.storage()
        
    @discardableResult
    func upload(imageData: Data, imageId: String) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            
            let storageRef = storage.reference()
            let riversRef = storageRef.child("images/\(imageId).jpg")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            _ = riversRef.putData(imageData, metadata: metadata) { (metadata, error) in
                guard let _ = metadata else {
                    continuation.resume(throwing: error ?? ApiError.custom(text: "putData error"))
                    return
                }
                continuation.resume(with: .success(imageId))
            }
        }
    }
    
    @discardableResult
    func deleteImageWith(id: String) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let storageRef = storage.reference()
            let riversRef = storageRef.child("images/\(id).jpg")
            riversRef.delete { error in
                if let error {
                    print("delete image error: ", error.localizedDescription)
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(with: .success(true))
                }
            }
        }
    }
    
    func getDownloadUrlFor(imageId: String) async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            let storageRef = storage.reference()
            let riversRef = storageRef.child("images/\(imageId).jpg")
            riversRef.downloadURL { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func loadImageData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
