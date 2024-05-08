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
        case edit(book: Book)
        
        var title: String {
            switch self {
            case .add:
                "Добавить книгу"
            case .edit:
                "Изменить книгу"
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let viewType: ViewType
    @State private var bookName = ""
    @State private var releaseYear = ""
    @State private var description = ""
    @State private var authorName = ""
    @State private var selectedGenre = ""
    @State private var selectedBookType = BookType.text
    
    @State private var genres = [BookGenre]()
    @State private var imageUrl: String?
    @State private var fileName: String?
    @State private var uploadError: UploadError?
    
    var isShowingUploadError: Binding<Bool> {
        Binding {
            uploadError != nil
        } set: { _ in
            uploadError = nil
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
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
                    TextField("Имя автора", text: $authorName)
                    Picker("Выберите жанр", selection: $selectedGenre) {
                        ForEach(genres, id: \.name) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Тип книги", selection: $selectedBookType) {
                        ForEach(BookType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section {
                    AdminFileUploadView(fileName: $fileName)
                }
                Section {
                    AdminImageUploadView(imageUrl: $imageUrl)
                }
            }
        }
        .onAppear {
            loadInitialData()
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
                .disabled(imageUrl == nil || fileName == nil)
            }
        }
        .navigationTitle(viewType.title)
        .alert(isPresented: isShowingUploadError, error: uploadError) { _ in
        } message: { error in
            Text(error.errorDescription ?? "")
        }
    }
    
    private func loadInitialData() {
        switch viewType {
        case .add:
            break
        case .edit(let book):
            bookName = book.name
            if let year = book.year { releaseYear = "\(year)" }
            description = book.description ?? ""
            selectedGenre = book.genre
            authorName = book.authorName ?? ""
            selectedBookType = BookType(rawValue: book.bookType) ?? .text
            imageUrl = book.imageUrl
            fileName = book.fileName
        }
        
        Task  {
            do {
                genres = try await Store.shared.getGenres()
                DispatchQueue.main.async {
                    switch viewType {
                    case .add:
                        selectedGenre = genres.first?.name ?? ""
                    case .edit(let book):
                        selectedGenre = book.genre
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func createBook() {
        guard let book = buildBook(bookId: UUID().uuidString, firestoreId: nil) else {
            return
        }
        Task {
            do {
                try await Store.shared.add(book: book)
                dismissSelf()
            } catch {
                uploadError = UploadError.custom(text: error.localizedDescription)
            }
        }
    }
    
    private func updateBook(oldBook: Book) {
        guard let book = buildBook(bookId: oldBook.id,
                                   firestoreId: oldBook.firestoreId) else {
            return
        }
        Task {
            do {
                try await Store.shared.update(book: book)
                dismissSelf()
            } catch {
                uploadError = UploadError.custom(text: error.localizedDescription)
            }
        }
    }
    
    private func buildBook(bookId: String, firestoreId: String?) -> Book? {
        var book = Book(id: bookId,
                        name: bookName,
                        year: Int(releaseYear),
                        format: nil,
                        description: description,
                        genre: selectedGenre,
                        authorName: authorName,
                        bookType: selectedBookType.rawValue,
                        imageUrl: imageUrl,
                        fileName: fileName)
        if let firestoreId {
            book.set(firestoreId: firestoreId)
        }
        return book
    }
    
    private func dismissSelf() {
        DispatchQueue.main.async {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    AdminEditBookView(viewType: .add)
}
