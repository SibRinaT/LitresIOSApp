//
//  AdminAddBookView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import SwiftUI
import PhotosUI

struct AdminAddBookView: View {
    
    @State private var bookName = ""
    @State private var releaseYear = ""
    @State private var description = ""
    
    @State private var imageItem: PhotosPickerItem?
    @State private var bookImage: Image?
    @State private var bookImageData: Data?
    
    @State private var showNoImageAlert = false
    
    
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
            Task {
                if let loadedData = try? await imageItem?.loadTransferable(type: Data.self) {
                    bookImageData = loadedData
                    if let uimg = UIImage(data: loadedData) {
                        bookImage = Image(uiImage: uimg)
                    }
                } else {
                    print("Failed to get image from library")
                }
            }
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
        Store.shared.add(book: book, imageData: bookImageData)
    }
}

#Preview {
    AdminAddBookView()
}
