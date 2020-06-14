//
//  ViewController.swift
//  Concentration
//
//  Created by 高浩铭 on 6/7/20.
//  Copyright © 2020 Haoming Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Fields
    let themes: [String] = ["Halloween", "Flags", "Faces", "Sports", "Animals", "Fruits", "Appliances"]
    
    var theme = "Halloween"
    
    let emojis: [String: [String]] = [
        "Halloween":    ["😱", "🦇", "🎃", "👻", "🍭", "😈", "🙀", "🍎"],
        "Flags":        ["🇧🇷", "🇧🇪", "🇯🇵", "🇨🇦", "🇺🇸", "🇵🇪", "🇮🇪", "🇦🇷"],
        "Faces":        ["😀", "🙄", "😡", "🤢", "🤡", "😱", "😍", "🤠"],
        "Sports":       ["🏌️", "🤼‍♂️", "🥋", "🏹", "🥊", "🏊", "🤾🏿‍♂️", "🏇🏿"],
        "Animals":      ["🦊", "🐼", "🦁", "🐘", "🐓", "🦀", "🐷", "🦉"],
        "Fruits":       ["🥑", "🍍", "🍆", "🍠", "🍉", "🍇", "🥝", "🍒"],
        "Appliances":   ["💻", "🖥", "⌚️", "☎️", "🖨", "🖱", "📱", "⌨️"]
    ]
    
    var emojiChoices = [String]()
    
    private var emoji = [Int: String]()
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // onLoad
    override func viewDidLoad() {
        newGame()
    }
    
    // Buttons
    @IBAction func clickNewGameButton(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModule()
        } else {
            print("error")
        }
    }
    
    // Outlets
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // Functions
    func newGame() {
        theme = themes[themes.count.arc4random]
        emojiChoices = emojis[theme]!
        emoji.removeAll()
        game.newGame()
        updateViewFromModule()
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
    
    private func emoji(for card: Card) -> String {
        if emojiChoices.count > 0, emoji[card.identifier] == nil {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}
