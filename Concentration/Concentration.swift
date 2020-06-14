//
//  Concentration.swift
//  Concentration
//
//  Created by 高浩铭 on 6/7/20.
//  Copyright © 2020 Haoming Gao. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func newGame() {
        flipCount = 0
        score = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].flippedOnce = false
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            
            // check if cards match
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                // not matched
                } else {
                    if cards[index].flippedOnce { score -= 1 }
                    if cards[matchIndex].flippedOnce { score -= 1 }
                }
                
                // make it face up and count flipped once
                cards[index].isFaceUp = true
                cards[index].flippedOnce = true
                cards[matchIndex].flippedOnce = true
            } else {
                // either no cards or 2 cards are facing up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at lease 1 pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}
