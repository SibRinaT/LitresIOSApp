//
//  BankCardStore.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 21.05.2024.
//

import Foundation

struct BankCard: Codable, Identifiable, Equatable {
    var id: String {
        number
    }
    
    
    let number: String
    let cvv: String
    let name: String
    let expirationDate: String
    
    var maskedNumber: String {
        
            return "*" + number.dropFirst(number.count - 4)

    }
}

struct BankCardStore {
    private static let userDefaults = UserDefaults.standard
    private static let cardsKey = "cardsKey"
    
    static func saveBank(card: BankCard) {
        var allCards = getCards()
        allCards.append(card)
        save(cards: allCards)
    }
    
    static func getCards() -> [BankCard] {
        do {
            if let data = userDefaults.data(forKey: cardsKey) {
                return try decodeCards(from: data)
            } else {
                return []
            }
        } catch {
            print(error)
            return []
        }
    }
    
    static func delete(card: BankCard) {
        var allCards = getCards()
        allCards.removeAll(where: { $0.number == card.number })
        save(cards: allCards)
    }
    
    private static  func save(cards: [BankCard]) {
        do {
            let data = try encode(cards: cards)
            userDefaults.setValue(data, forKey: cardsKey)
        } catch {
            print(error)
        }
    }
    
    private static  func decodeCards(from data: Data) throws -> [BankCard] {
        return try JSONDecoder().decode([BankCard].self, from: data)
    }
    
    private static  func encode(cards: [BankCard]) throws -> Data {
        return try JSONEncoder().encode(cards)
    }
}
