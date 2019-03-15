//
//  ViewController.swift
//  Memo
//
//  Created by Ирина on 21.01.2019.
//  Copyright © 2019 Ирина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(countOfPairsOfCards: (cardsButton.count+1)/2)

    lazy var emojiChoices = game.choiceTheme()
    var emoji = [Int: String]()
    var openCards = [String]()
    
    var scopeCount = 0 
    
    @IBAction func touchButton(_ sender: UIButton) {
        if let buttonNumber = cardsButton.index(of: sender) {
            game.chooseCard(at: buttonNumber)
            updateViewFromModel()
            count.text = "Flips: \(game.flipCount)"
            scope.text = "Scope: \(scopeCount)"
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        emojiChoices = game.choiceTheme()
        game = Memory(countOfPairsOfCards: (cardsButton.count+1)/2)
        updateViewFromModel()
        openCards = []
    }
    
    @IBOutlet weak var scope: UILabel!
    @IBOutlet var cardsButton: [UIButton]!
    @IBOutlet weak var count: UILabel!

    
    func updateViewFromModel() {
        for index in cardsButton.indices {
            let button = cardsButton[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if game.indexOfOneAndOnlyFaceUpCard == nil && !card.isMatched {
                    didOpenCard(emoji(for: card))
                } else if game.indexOfOneAndOnlyFaceUpCard == nil && card.isMatched  {
                    scopeCount += 1
                    print("scope")
                    print(scopeCount)
                }
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2213943679, green: 0.6471478889, blue: 0.9361714784, alpha: 0) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    
    func didOpenCard (_ cardTitle: String) {
        if openCards.contains(cardTitle) {
            scopeCount -= 1
        } else {
            openCards.append(cardTitle)
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.indetifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.indetifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.indetifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

