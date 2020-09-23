//
//  Dealer.swift
//  HW1
//
//  Created by Azamat on 23.09.2020.
//

import Foundation

enum GameStatus {
    case didNotStart
    case continues
    case playerWon
    case dealerWon
    case draw
}

class Dealer {
    private static let POINTS_BOUND = 17

    private var cardDeck: CardDeck
    private var dealerHand = Hand()
    private var playerHand = Hand() {
        didSet {
            switch playerHand.handStatus {
            case .inGame:
                break
            case .blackjack:
                gameStatus = .playerWon
            case .lost:
                gameStatus = .dealerWon
            }
        }
    }

    private(set) var gameStatus: GameStatus = .didNotStart

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

    private func getCard() -> Card {
        guard !cardDeck.isEmpty else {
            return EMPTY_CARD
        }
        return cardDeck.getRandomCard() ?? EMPTY_CARD
    }

    func startGame() {
        guard gameStatus == .didNotStart else {
            return
        }
        dealerHand.put(getCard())
        dealerHand.put(getCard())

        playerHand.put(getCard())
        playerHand.put(getCard())

        gameStatus = .continues
    }
    
    func makeMove() {
        guard gameStatus == .continues else {
            return
        }
        playerHand.put(getCard())
    }

    func finishGame() {
        guard gameStatus == .continues else {
            return
        }
        while dealerHand.points < Dealer.POINTS_BOUND && !cardDeck.isEmpty {
            dealerHand.put(getCard())
        }
        
        if playerHand.points > dealerHand.points {
            gameStatus = .playerWon
        } else if playerHand.points == dealerHand.points {
            gameStatus = .draw
        } else {
            gameStatus = .dealerWon
        }
    }

}
