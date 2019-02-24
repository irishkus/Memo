//
//  Card.swift
//  Memo
//
//  Created by Ирина on 18.02.2019.
//  Copyright © 2019 Ирина. All rights reserved.
//

import Foundation

struct Card {
    var isMatched = false
    var isFaceUp = false
    var indetifier: Int
    static var identifierFactory = 0
    
    static func getUniqueIndetifier() -> Int{
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.indetifier = Card.getUniqueIndetifier()
    }
}
