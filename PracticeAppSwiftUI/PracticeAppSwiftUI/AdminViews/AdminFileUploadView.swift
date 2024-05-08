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
    
    var body: some View {
        if let fileName {
            HStack {
                Text(fileName)
                Spacer()
                Button("Удалить") {
                    deleteFile()
                }
                .foregroundColor(.red)
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
    
    private func uploadFileFrom(url: URL) {
        Task {
            do {
                let data = try Data(contentsOf: url)
                let fileName = url.lastPathComponent
                try await ImageStorage.shared.upload(data: data, path: "files/\(fileName)")
                self.fileName = fileName
            } catch {
                print(error)
            }
        }
    }
    
    private func deleteFile() {
        guard let fileName else { return }
        Task {
            try await ImageStorage.shared.deleteFileFrom(path: "files/\(fileName)")
            self.fileName = nil
        }
    }
}
