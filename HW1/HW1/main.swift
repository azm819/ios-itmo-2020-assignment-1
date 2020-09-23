//
//  main.swift
//  HW1
//
//  Created by Azamat on 23.09.2020.
//

import Foundation

func playGame() {
    print("!!!!! NEW GAME !!!!!")
    let dealer = Dealer()
    dealer.startGame()

    dealer.printDealerHand()
    dealer.printPlayerHand()
    outer: while dealer.gameStatus == .continues {
        print("-----------------------------------------")
        print("%%% Do you want to make a move? (y/n) %%%")

        switch readLine()?.lowercased() {
        case "y":
            dealer.makeMove()
            dealer.printPlayerHand()
            break
        case "n":
            break outer
        default:
            continue
        }
    }

    if dealer.gameStatus == .continues {
        dealer.finishGame()
    }
    dealer.printDealerHand()
    dealer.printPlayerHand()

    switch dealer.gameStatus {
    case .didNotStart:
        break
    case .continues:
        break
    case .playerWon:
        print("You won!!!")
        break
    case .dealerWon:
        print("You lost")
        break
    case .draw:
        print("It's a draw")
        break
    }
}

playGame()
outer: while true {
    print("+++++++++++++++++++++++++++++++++++++++++++++++")
    print("%%% Do you want to play another game? (y/n) %%%")

    switch readLine()?.lowercased() {
    case "y":
        playGame()
        break
    case "n":
        break outer
    default:
        continue
    }
}
