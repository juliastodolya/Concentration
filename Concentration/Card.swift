//
//  Card.swift
//  Concentration
//
//  Created by Юлия on 27.12.2020.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var ​identifierFactory​ = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.​identifierFactory​ += 1
        return Int(Card.​identifierFactory​)
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
