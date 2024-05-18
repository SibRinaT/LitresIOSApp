//
//  AdminFileLoadView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 08.05.2024.
//

import SwiftUI

struct AdminFileUploadView: View {
    @Binding var fileName: String?
    @Binding var bookType: BookType
    @State private var isFileImporterPresented = false
    @State private var isAudioAlertPresented = false
    @State private var isLoading = false
    @State private var mp3Link = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                if let fileName {
                    HStack {
                        Button(fileName) {
                            
                        }
                        .buttonStyle(.plain)
                        Spacer()
                        Button("Удалить") {
                            deleteFile()
                        }
                        .foregroundColor(.red)
                        .buttonStyle(.plain)
                    }
                } else {
                    Button("Добавить файл") {
                        switch bookType {
                        case .text:
                            isFileImporterPresented = true
                        case .audio:
                            isAudioAlertPresented = true
                        }
                    }
                    .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.item]) { result in
                        switch result {
                        case .success(let url):
                            uploadFileFrom(url: url)
                        case .failure(let failure):
                            print(failure.localizedDescription)
                        }
                    }
                }
            }
        }
        .alert("Загрузка mp3", isPresented: $isAudioAlertPresented) {
            TextField("mp3 link", text: $mp3Link)
                .textInputAutocapitalization(.never)
            Button("OK", action: downloadMp3)
            Button("Отмена", role: .cancel) { }
        } message: {
            Text("Скопируйте ссылку на mp3 файл")
        }
    }
    
    private func downloadMp3() {
        isLoading = true
        guard let mp3Url = URL(string: mp3Link) else {
            return
        }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: mp3Url)
                let fileName = mp3Url.lastPathComponent
                try await ImageStorage.shared.upload(data: data, path: "files/\(fileName)")
                DispatchQueue.main.async {
                    self.fileName = fileName
                    self.isLoading = false
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func uploadFileFrom(url: URL) {
        isLoading = true
        Task {
            do {
                let data = try Data(contentsOf: url)
                let fileName = url.lastPathComponent
                try await ImageStorage.shared.upload(data: data, path: "files/\(fileName)")
                DispatchQueue.main.async {
                    self.fileName = fileName
                    self.isLoading = false
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func deleteFile() {
        guard let fileName else { return }
        isLoading = true
        Task {
            try await ImageStorage.shared.deleteFileFrom(path: "files/\(fileName)")
            DispatchQueue.main.async {
                self.fileName = nil
                self.isLoading = false
            }
        }
    }
}
