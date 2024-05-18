//
//  BookDetailsBody.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import Foundation
import SwiftUI

struct BookDetailsBody: View {
    @Environment(\.authService) var authService
    var book: Book
    @State var isExpanded = false
    @State private var selectedTab = "One"
    @State var userCanRead = true
    let imageStorage = ImageStorage.shared
    @Binding var reviews: [Review]
    
    @State private var isSubscriptionViewPresented = false
    @State private var bookText = ""
    @State private var bookMp3Data: Data?
    @State private var bookDataIsLoading = false
    
    var isReaderBookViewPresented: Binding<Bool> {
        Binding {
            !bookText.isEmpty
        } set: { _ in
            bookText = ""
        }
    }
    
    var isMp3BookViewPresented: Binding<Bool> {
        Binding {
            bookMp3Data != nil
        } set: { _ in
            bookMp3Data = nil
        }
    }
    
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button(action: { // для скачивания
                                downloadBookButtonPressed()
                            }) {
                                if bookDataIsLoading {
                                    Capsule()
                                        .fill(Color("InactiveColor").opacity(0.5))
                                        .frame(width: 100, height: 35)
                                        .overlay {
                                            ProgressView().progressViewStyle(.circular)
                                        }
                                } else {
                                    Capsule()
                                        .fill(userCanRead ? Color("MainColor") : Color("SecondaryColor").opacity(0.5))
                                        .frame(width: 100, height: 35)
                                        .overlay {
                                            Text("Читать")
                                                .foregroundColor(.white)
                                                .font(.custom("AmericanTypewriter", size: 20))
                                        }
                                }
                            }
                            .disabled(bookDataIsLoading)
                            Spacer()
                        }
                        
                        Text(book.bookType)
                            .font(.custom("AmericanTypewriter", size: 16))
                            .foregroundColor(Color(.white))
                            .padding(.bottom, -20)
                        
                        //                        Text("Release date: \(book.year)") // закомитил потому что ошибка, а если запулить то придется скачаивать FB заново))
                        //                        switch BookType(rawValue: book.bookType) {
                        //                        case .text:
                        //                            if let pages = book.textBookDetails?.pages {
                        //                                Text("Pages: \(pages)")
                        //                            }
                        //                        case .audio:
                        //                            if let len = book.audioBookDetails?.length {
                        //                                Text("Length: \(len)")
                        //                            }
                        //                        case .none:
                        //                            Color.white
                        //                        }
                        
                    }
                    Spacer()
                    //                    if let linkedBook = book.linkedBook {
                    //                        SwitchBookTypeView(book: linkedBook)
                    //                    }
                }
                .padding(.vertical)
                //                TagsView(tags: book.tags)
                
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: { Text(book.description ?? "") },
                    label: { Text("Описание книги \(book.name)") }
                )
                .font(.custom("AmericanTypewriter", size: 16))
                .foregroundColor(Color(.white))
                
                //                Text("\nИздатель: \(book.publisher)")
                //                Text("Дата выхода на ЧитайBook: \(book.creatingDate.formatted(date: .long, time: .omitted))")
                Spacer(minLength: 20)
                if !reviews.isEmpty {
                    Text(reviews.count == 1 ? "Отзыв" : "Отзывы")
                        .foregroundColor(.white)
                        .font(.custom("AmericanTypewriter", size: 36))
                        .bold()
                }
                
                NavigationLink(destination: AddNewFeedbackView(book: book, viewType: .add)) {
                    Rectangle()
                        .foregroundColor(Color("SecondaryColor"))
                        .frame(width: 150, height: 40)
                        .cornerRadius(16)
                        .overlay (
                            Text("Написать отзыв")
                                .padding(.vertical)
                                .foregroundColor(Color("InactiveColor"))
                                .font(.custom("AmericanTypewriter", size: 16))
                        )
                }
                ForEach(reviews) { review in
                    BookReview(review: review)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
            }
            .padding()
            
            //        NavigationView {
            //                       NavigationLink(destination: PlaysoundView()) {
            //                           Text("Перейти к проигрывателю")
            //                       }
            //                   }
            //        .padding()
        }
        .popover(isPresented: isReaderBookViewPresented) {
            if !bookText.isEmpty {
                ReaderBookView(isSheetPresented: isReaderBookViewPresented, book: book, bookText: bookText)
            }
        }
        .popover(isPresented: isMp3BookViewPresented) {
            if !(bookMp3Data?.isEmpty ?? true) {
                // MP3 listener here, pass bookMp3Data
            }
        }
    }
    
    private func downloadBookButtonPressed() {
        if book.isFree {
            loadBookAndOpen()
        } else {
            if let user = authService.user, user.isSubscriptionEnabled {
                loadBookAndOpen()
            } else {
                isSubscriptionViewPresented = true
            }
        }
    }
    
    private func loadBookAndOpen() {
        bookDataIsLoading = true
        Task {
            do {
                let fileURL = try await imageStorage.getUrlForFile(name: book.fileName)
                let data = try await ImageStorage.shared.loadData(from: fileURL)
                switch BookType(rawValue: book.bookType)! {
                case .audio:
                    bookMp3Data = data
                case .text:
                    bookText = String(data: data, encoding: .utf8) ?? ""
                }
                hideLoadingIndicator()
            } catch {
                print("Error:", error)
                hideLoadingIndicator()
            }
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            bookDataIsLoading = false
        }
    }
}

//#Preview {
//    NavigationStack {
//        BookDetails(book: MockData.getBook())
//    }
//}
