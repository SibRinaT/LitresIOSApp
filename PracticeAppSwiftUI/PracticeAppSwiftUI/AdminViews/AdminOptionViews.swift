//
//  AdminOptionViews.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 06.05.2024.
//

import SwiftUI

struct AdminOptionViews: View {
    @Binding var isSheetPresented: Bool
    
    let options = [
        "Books"
    ]
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: AdminBooksList()) {
                    Text("Books")
                }
            }
            .navigationTitle("Admin Panel")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Text("Закрыть")
                    }

                }
            }
        }
    }
}

#Preview {
    AdminOptionViews(isSheetPresented: .constant(true))
}
