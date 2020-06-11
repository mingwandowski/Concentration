//
//  ViewController.swift
//  Concentration
//
//  Created by 高浩铭 on 6/7/20.
//  Copyright © 2020 Haoming Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        updateViewFromModule()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModule()
        } else {
            print("error")
        }
    }
    
    private func updateViewFromModule() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal);
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["😱", "🦇", "🎃", "👻", "🍭", "🍬", "😈", "🙀", "🍎"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emojiChoices.count > 0, emoji[card.identifier] == nil {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
        /* same as:
         if emoji[card.identifier] != nil {
             return emoji[card.identifier]!
         } else {
             return "?"
         }
         */
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
