//
//  BankCardStore.swift
//  PracticeAppSwiftUI
//
//  Created by Artem on 21.05.2024.
//

import Foundation

struct BankCard: Codable {
    let number: String
    let cvv: String
    let name: String
    let expirationDate: String
}

struct BankCardStore {
    private static  let userDefaults = UserDefaults.standard
    
    static func saveBank(card: BankCard) {
        var allCards = getCards()
        allCards.append(card)
        save(cards: allCards)
    }
    
    static func getCards() -> [BankCard] {
        do {
            if let data = userDefaults.data(forKey: "cards") {
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
            userDefaults.setValue(data, forKey: "cards")
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
