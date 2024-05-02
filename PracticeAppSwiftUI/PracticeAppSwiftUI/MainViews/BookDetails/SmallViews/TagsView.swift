//
//  TagsView.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct TagsView: View {
    var tags: [Tag]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(TagsViewModel.getRows(tags: tags), id:\.self) { rows in
                HStack(spacing: 6) {
                    ForEach(rows) { tag in
                        NavigationLink(destination: SearchView(viewModel: SearchViewModel(tagID: tag.id))) {
                            HStack {
                                Text(tag.name)
                                    .font(.system(size: 16))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .overlay(Capsule().fill(.gray.opacity(0.3)))
                            }
                        }
                    }
                }
                .frame(height: 28)
                .padding(.bottom, 10)
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview {
    NavigationStack {
        TagsView(tags: MockData.getBook().tags)
    }
}
