//
//  Hand.swift
//  HW1
//
//  Created by Azamat on 23.09.2020.
//

import Foundation

enum HandStatus {
    case inGame
    case blackjack
    case lost
}

struct Hand {
    private static let MAX_POINTS = 21

    private var cards = [Card]()

    private let ownerName: String

    private(set) var points: Int = .zero {
        didSet {
            sumExceeded21 = sumExceeded21 || points > Hand.MAX_POINTS
        }
    }

    private var sumExceeded21: Bool = false {
        didSet {
            if oldValue != sumExceeded21 && sumExceeded21 {
                recountPoints()
            }
        }
    }

    var handStatus: HandStatus {
        if points < Hand.MAX_POINTS {
            return .inGame
        } else if points == Hand.MAX_POINTS {
            return .blackjack
        } else {
            return .lost
        }
    }

    init(of name: String) {
        self.ownerName = name
    }

    mutating func put(_ newCard: Card) {
        guard newCard.rank != .back else {
            return
        }
        cards.append(newCard)

        recountPoints()
    }

    private func points(of card: Card) -> Int {
        switch card.rank {
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .jack:
            return 10
        case .queen:
            return 10
        case .king:
            return 10
        case .ace:
            return sumExceeded21 ? 1 : 11
        case .back:
            return 0
        }
    }

    private mutating func recountPoints() {
        points = .zero
        for card in cards {
            points += points(of: card)
        }
    }

    func printHand() {
        print("*******************")
        print("\(ownerName)'s hand")
        for card in cards {
            print(card.character, terminator: " ")
        }
        print("\npoints: \(points)")
    }

}
