//
//  AdminImageUploadView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 08.05.2024.
//

import SwiftUI
import PhotosUI

struct AdminImageUploadView: View {
    @State private var imageItem: PhotosPickerItem?
    @State private var bookImage: Image?
    @Binding var imageUrl: String?

    
    var body: some View {
        VStack {
            if imageUrl != nil {
                bookImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Button("Удалить") {
                    deleteOldImageIfNeeded()
                }
                .foregroundColor(.red)
            } else {
                PhotosPicker("Обложка книги", selection: $imageItem, matching: .images)
            }
        }
        .onChange(of: imageItem) {
            prepareAndUploadImage()
        }
        .task {
            do {
                if let imageUrl = URL(string: imageUrl ?? "") {
                    let imageData = try await ImageStorage.shared.loadImageData(from: imageUrl)
                    if let uiImage = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            bookImage = Image(uiImage: uiImage)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func prepareAndUploadImage() {
        Task {
            if let loadedData = try? await imageItem?.loadTransferable(type: Data.self) {
                DispatchQueue.main.async {
                    if let uimg = UIImage(data: loadedData) {
                        if let resized = uimg.resizeWithWidth(width: 200) {
                            bookImage = Image(uiImage: resized)
                            if let data = resized.jpegData(compressionQuality: 1) {
                                uploadImage(data: data)
                            }
                        } else {
                            bookImage = Image(uiImage: uimg)
                            if let data = uimg.jpegData(compressionQuality: 0.1) {
                                uploadImage(data: data)
                            }
                        }
                    }
                }
            } else {
                print("Failed to get image from library")
            }
        }
    }
    
    private func deleteOldImageIfNeeded() {
        guard let imageUrl, let url = URL(string: imageUrl) else { return }
        Task {
            let imageName = url.deletingPathExtension().lastPathComponent
            let path = "images/\(imageName).jpg"
            try await ImageStorage.shared.deleteFileFrom(path: path)
            self.bookImage = nil
            self.imageUrl = nil
        }
    }
    
    private func uploadImage(data: Data) {
        Task {
            do {
                self.imageUrl = try await ImageStorage.shared.upload(imageData: data).absoluteString
            } catch {
                print(error)
            }
        }
    }
}

private extension UIImage {
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
