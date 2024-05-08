//
//  AdminFileLoadView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 08.05.2024.
//

import SwiftUI

struct AdminFileUploadView: View {
    @Binding var fileName: String?
    @State private var isFileImporterPresented = false
    @State private var isLoading = false
    
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
                        isFileImporterPresented = true
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
