//
//  AdminFileLoadView.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 08.05.2024.
//

import SwiftUI

struct AdminFileUploadView: View {
    @State private var fileURL: URL?
    @State private var isFileImporterPresented = false
    
    var body: some View {
        Button("Добавить файл") {
            isFileImporterPresented = true
        }
        .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.item]) { result in
            switch result {
            case .success(let url):
                self.fileURL = url
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        if let fileURL {
            Text(fileURL.lastPathComponent)
        }
    }
}

#Preview {
    AdminFileUploadView()
}
