//
//  Dealer.swift
//  HW1
//
//  Created by Azamat on 23.09.2020.
//

import Foundation

class Dealer {
    private static let POINTS_BOUND = 17

    private(set) var cardDeck: CardDeck
    private(set) var hand = Hand()

    private var gameIsBegan: Bool = false

    init(cards: [Card]) {
        self.cardDeck = CardDeck(cards: cards)
    }

    /// For default Card deck with 52 cards
    convenience init() {
        var defaultCards = [Card]()
        for rank in Ranks.allCases {
            for suit in Suits.allCases {
                defaultCards.append(Card(rank: rank, suit: suit))
            }
        }
        self.init(cards: defaultCards)
    }

    func getCard() -> Card {
        guard !cardDeck.isEmpty else {
            return EMPTY_CARD
        }
        return cardDeck.getRandomCard() ?? EMPTY_CARD
    }

    func beginGame() -> (Card, Card) {
        guard !gameIsBegan else {
            return (EMPTY_CARD, EMPTY_CARD)
        }

        defer {
            gameIsBegan = true
        }
        hand.put(getCard())
        hand.put(getCard())

        return (getCard(), getCard())
    }

    func finishGame() {
        guard gameIsBegan else {
            return
        }
        while hand.points < Dealer.POINTS_BOUND && !cardDeck.isEmpty {
            hand.put(getCard())
        }
    }

}
