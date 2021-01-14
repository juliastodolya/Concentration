//
//  Card.swift
//  Concentration
//
//  Created by Юлия on 27.12.2020.
//

import Foundation

struct Card: Hashable {
    
    //MARK: - Public properties
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    //MARK: - Private properties
    
    private static var ​identifierFactory​ = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.​identifierFactory​ += 1
        return Int(Card.​identifierFactory​)
    }
    
    //MARK: - Initializers
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
