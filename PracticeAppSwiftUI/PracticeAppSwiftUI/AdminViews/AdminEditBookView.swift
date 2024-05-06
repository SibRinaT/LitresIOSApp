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

struct AdminEditBookView: View {
    enum ViewType {
        case add
        case edit(book: Book1)
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let viewType: ViewType
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
    
    var title: String {
        switch viewType {
        case .add:
            "Добавить книгу"
        case .edit:
            "Изменить книгу"
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
        .task {
            switch viewType {
            case .add:
                break
            case .edit(let book):
                self.bookName = book.name
                if let year = book.year {
                    self.releaseYear = "\(year)"
                }
                self.description = book.description ?? ""
                
                do {
                    let imageUrl = try await ImageStorage.shared.getDownloadUrlFor(imageName: book.id)
                    let imageData = try await ImageStorage.shared.loadImageData(from: imageUrl)
                    if let uiImage = UIImage(data: imageData) {
                        bookImage = Image(uiImage: uiImage)
                    }
                    
                } catch {
                    
                }
            }
        }
        .onChange(of: imageItem) {
            updateImage()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    switch viewType {
                    case .add:
                        createBook()
                    case .edit(let book):
                        updateBook(oldBook: book)
                    }
                } label: {
                    Text("Готово")
                }
                
            }
        }
        .navigationTitle(title)
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
    
    private func createBook() {
        guard let bookImageData else {
            showNoImageAlert = true
            return
        }
        let book = buildBook(bookId: UUID().uuidString, firestoreId: nil)
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
    
    private func updateBook(oldBook: Book1) {
        Task {
            let book = buildBook(bookId: oldBook.id,
                                 firestoreId: oldBook.firestoreId)
            do {
                try await Store.shared.update(book: book, imageData: bookImageData)
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } catch {
                uploadError = UploadError.custom(text: error.localizedDescription)
            }
        }
    }
    
    private func buildBook(bookId: String, firestoreId: String?) -> Book1 {
        var book = Book1(id: bookId,
                         name: bookName,
                         year: Int(releaseYear),
                         format: nil,
                         description: description)
        if let firestoreId {
            book.set(firestoreId: firestoreId)
        }
        return book
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
    AdminEditBookView(viewType: .add)
}
