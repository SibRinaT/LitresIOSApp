//
//  AdminAddBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import SwiftUI
import PhotosUI
import UIKit

private enum UploadError: LocalizedError {
    case custom(text: String)
    var errorDescription: String? {
        switch self {
        case .custom(let text):
            return text
        }
    }
}

struct AdminAddBookView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var bookName = ""
    @State private var releaseYear = ""
    @State private var description = ""
    
    @State private var imageItem: PhotosPickerItem?
    @State private var bookImage: Image?
    @State private var bookImageData: Data?
    
    @State private var showNoImageAlert = false
    @State private var uploadError: UploadError?
    
    var isShowingUploadError: Binding<Bool> {
        Binding {
            uploadError != nil
        } set: { _ in
            uploadError = nil
        }
    }
    
    var body: some View {
        Form {
            List {
                TextField("Название", text: $bookName)
                TextField("Год выпуска", text: $releaseYear)
                    .keyboardType(.numberPad)
                ZStack(alignment: .leading) {
                    if description.isEmpty {
                        Text("Описание")
                            .opacity(0.3)
                            .padding(.horizontal, 3)
                    }
                    TextEditor(text: $description)
                }
                PhotosPicker("Обложка книги", selection: $imageItem, matching: .images)
                bookImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: imageItem) {
            updateImage()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveBook()
                } label: {
                    Text("Готово")
                }
                
            }
        }
        .navigationTitle("Добавить книгу")
        .alert("Выберите обложку для книги", isPresented: $showNoImageAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert(isPresented: isShowingUploadError, error: uploadError) { _ in
        } message: { error in
            Text(error.errorDescription ?? "")
        }
    }
    
    private func updateImage() {
        Task {
            if let loadedData = try? await imageItem?.loadTransferable(type: Data.self) {
                DispatchQueue.main.async {
                    if let uimg = UIImage(data: loadedData) {
                        if let resized = uimg.resizeWithWidth(width: 400) {
                            bookImage = Image(uiImage: resized)
                            bookImageData = resized.jpegData(compressionQuality: 1)
                        } else {
                            bookImage = Image(uiImage: uimg)
                            bookImageData = uimg.jpegData(compressionQuality: 0.2)
                        }
                    }
                }

            } else {
                print("Failed to get image from library")
            }
        }
    }
    
    private func saveBook() {
        guard let bookImageData else {
            showNoImageAlert = true
            return
        }
        let book = Book1(id: UUID().uuidString,
                         name: bookName,
                         year: Int(releaseYear) ?? 0,
                         format: nil)
        Task {
            do {
                try await Store.shared.add(book: book, imageData: bookImageData)
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } catch {
                uploadError = UploadError.custom(text: error.localizedDescription)
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

#Preview {
    AdminAddBookView()
}
