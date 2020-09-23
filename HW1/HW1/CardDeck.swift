//
//  Cards.swift
//  HW1
//
//  Created by Azamat on 23.09.2020.
//

import Foundation

let EMPTY_CARD = Card(rank: .back, suit: .spades)

enum Ranks: Int, CaseIterable {
    case back = 0x0
    case ace = 0x1
    case two = 0x2
    case three = 0x3
    case four = 0x4
    case five = 0x5
    case six = 0x6
    case seven = 0x7
    case eight = 0x8
    case nine = 0x9
    case ten = 0xA
    case jack = 0xB
/// case knight = 0xC
    case queen = 0xD
    case king = 0xE
}

enum Suits: Int, CaseIterable {
    case clubs = 0x1F0D0
    case diamonds = 0x1F0C0
    case hearts = 0x1F0B0
    case spades = 0x1F0A0
}

struct Card {
    let rank: Ranks
    private let suit: Suits

    let character: Character

    init(rank: Ranks, suit: Suits) {
        self.rank = rank
        self.suit = suit
        character = Character(UnicodeScalar(suit.rawValue + rank.rawValue) ?? "\u{1F0A0}")
    }
}

struct CardDeck {
    private var cards = [Card]()
    var isEmpty: Bool {
        return cards.isEmpty
    }

    init(cards: [Card]) {
        self.cards = cards
    }

    mutating func getRandomCard() -> Card? {
        guard !cards.isEmpty else {
            return nil
        }

        return cards.remove(at: Int.random(in: 0..<cards.count))
    }

}
