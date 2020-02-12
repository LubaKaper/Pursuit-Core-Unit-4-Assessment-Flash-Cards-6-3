//
//  CardModel.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

//struct CardInfo: Codable {
//    let cards: [Card]
//}

struct CreatedCard: Codable & Equatable {
    let question: String
    let factOne: String
    let factTwo: String
}

struct Card: Codable & Equatable {
    let quizTitle: String
    let facts: [String]
}

extension Card {
    static func getCards() -> [Card] {
        var cards = [Card]()
        
        guard let filrURL = Bundle.main.url(forResource: "Card", withExtension: "json") else {
            fatalError("could not locate json")
        }
        do {
            let data = try Data( contentsOf: filrURL)
            let cardData = try JSONDecoder().decode([Card].self, from: data)
            cards = cardData
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return cards 
    }
}
