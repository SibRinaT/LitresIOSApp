//
//  BookDetailsBody.swift
//  PracticeAppSwiftUI
//
//  Created by Ainur on 02.05.2024.
//

import SwiftUI

import Foundation
import SwiftUI

struct BookDetailsBody: View {
    var book: Book
    @State var isExpanded = false
    @State private var selectedTab = "One"
    @State var userCanRead = true
    let imageStorage = ImageStorage.shared
    @State private var reviews = [Review]()
    @State private var isSubscriptionViewPresented = false
    @State private var isReaderViewPresented = false
    @State private var bookText: String?
    
    var body: some View {
        ZStack {
            Color("BackColor")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button(action: {
                                downloadBookButtonPressed()
                            }) {
                                Rectangle()
                                    .frame(width: 100, height: 25)
                                    .foregroundColor(userCanRead ? Color("MainColor") : Color("InactiveColor").opacity(0.5))
                                    .cornerRadius(16)
                                    .overlay(
                                        Text("Читать")
                                            .foregroundColor(.white)
                                            .font(.custom("AmericanTypewriter", size: 20))
                                    )
                            }
                            Spacer()
                        }
                       
                        Text(book.bookType)
                            .font(.custom("AmericanTypewriter", size: 16))
                            .foregroundColor(Color(.white))
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
                        .font(.largeTitle)
                        .bold()
                }
                NavigationLink(destination: AddNewFeedbackView(book: book)) {
                    Text("Написать отзыв")
                        .padding(.vertical)
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
        .task {
            do {
                self.reviews = try await Store.shared.getReviews(for: book.id)
            } catch {
                print(error)
            }
        }
        .popover(isPresented: $isSubscriptionViewPresented) {
            SubscriptionView(isSheetPresented: $isSubscriptionViewPresented)
        }
        .popover(isPresented: $isReaderViewPresented) {
            if let bookText {
                ReaderBookView(isSheetPresented: $isReaderViewPresented, bookText: bookText)
            }
        }
    }
    
    private func downloadBookButtonPressed() {
        Task {
            do {
                if let user = try await AuthService.shared.fetchUserInfo(), user.isSubscriptionEnabled || book.isFree {
                    let fileURL = try await imageStorage.getUrlForFile(name: book.name)
                    let data = try await ImageStorage.shared.loadData(from: fileURL)
                    bookText = String(data: data, encoding: .utf8)
                    isReaderViewPresented = true
                    
                    
                    // TODO open reader and pass text
                } else {
                    isSubscriptionViewPresented = true
                }
            } catch {
                print("Error:", error)
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        BookDetails(book: MockData.getBook())
//    }
//}
