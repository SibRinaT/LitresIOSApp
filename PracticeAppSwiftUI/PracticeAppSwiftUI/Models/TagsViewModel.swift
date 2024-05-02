//
//  TagsViewModel.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import UIKit

class TagsViewModel {
    
    static func getRows(tags: [Tag]) -> [[Tag]] {
        var tags = tags
        guard !tags.isEmpty else {
            return [[]]
        }
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var totalWidth: CGFloat = 0
        let screenWidth = UIScreen.main.bounds.width - 10
        let tagSpacing: CGFloat = 46
    
        for index in 0..<tags.count {
            tags[index].size = tags[index].name.getSize()
        }
        
        tags.forEach { tag in
            totalWidth += (tag.size + tagSpacing)
            if totalWidth > screenWidth {
                totalWidth = (tag.size + tagSpacing)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            } else {
                currentRow.append(tag)
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        return rows
    }
}

private extension String {
    func getSize() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}

