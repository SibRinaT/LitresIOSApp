//
//  SearchView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel: SearchViewModel
    
    var body: some View {
        AsyncContentView(source: viewModel) { books in
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetails(book: book)) {
                        SearchBookView(book: book)
                    }
                }
            }
            .listRowSpacing(10)
        }
    }
}

@Observable
class SearchViewModel: LoadableObject {
    typealias Output = [Book1]
        
    private(set) var state: LoadingState<[Book1]>
    private let tagID: Tag.ID
    @MainActor private let loader = Loader()
    
    init(tagID: Tag.ID) {
        self.tagID = tagID
        self.state = .idle
    }
    
    @MainActor func load() {
        state = .loading
        
        loader.loadBooks(with: tagID) { [weak self] result in
            switch result {
            case .success(let article):
                print("success")
                self?.state = .loaded(article)
            case .failure(let error):
                print("error")
                self?.state = .failed(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(viewModel: SearchViewModel(tagID: MockData.getBook().tags.randomElement()!.id))
    }
}
