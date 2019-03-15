//
//  Memory.swift
//  Memo
//
//  Created by Ирина on 18.02.2019.
//  Copyright © 2019 Ирина. All rights reserved.
//

import Foundation

class Memory {
    
    var cards = [Card]()
    var sortCards = [Card]()
    var openCards = [String]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].indetifier == cards[index].indetifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        flipCount += 1
    }
   
    func choiceTheme() -> [String] {
        let animals = ["🦁","🐷","🦊","🐻","🐒","🐼","🐯","🐭","🐴","🐶","🐮","🐨","🐰","🐹","🐗","🐺"]
        let birds = ["🐥","🦉","🐤","🦆","🦅","🐔","🐧","🐦","🦇","🐣"]
        let insects = ["🦋","🐝","🐛","🐌","🐞","🐜","🦗","🕷","🦂","🐢","🐍","🦎","🐚"]
        let fruits = ["🍏","🍎","🍐","🍊","🍋","🍌","🍑","🍍","🥥","🥝","🍈"]
        let transport = ["🚔","🚖","🚑","🛵","🚲","🏎","🛫","🚀","🛸","🚃","⛵️","🚤","🚠","🚂","🚇","🚎"]
        let smilies = ["💄","👍","🤑","👅","🎃","😍","😭","👠","👨‍👩‍👧‍👦","💃","👼","👰","🧠","👀","👽","🤡","👺","😈"]
        let theme = [animals, birds, insects, fruits, transport, smilies]
        let randomIndex = Int(arc4random_uniform(UInt32(theme.count)))
        return theme[randomIndex]
    }
    
    init (countOfPairsOfCards: Int){
        for _ in 1...countOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        while (cards.count > 0) {
            let index = Int (arc4random_uniform(UInt32(cards.count)))
            sortCards.append(cards.remove(at: index))
        }
        cards = sortCards
    }
}
