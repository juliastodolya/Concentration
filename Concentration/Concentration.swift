//
//  Concentration.swift
//  Concentration
//
//  Created by Юлия on 27.12.2020.
//

import Foundation

struct Concentration {
    
    //MARK: - Private properties
    
    private(set) var cards: [Card] = []
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    private(set) var flipCount = 0
    
    private struct Points {
        static let matchBonus = 20
        static let missMatchPenalty = 5
        static let maxTimePenalty = 5
    }
    
    private var dateClick: Date?
    private var timePenalty: Int {
        return min(dateClick?.sinceNow ?? 0, Points.maxTimePenalty)
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set (newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                //принимает значение ​true​ только в том случае, если индекс карты совпадает с установленным кем-то индексом​ indexOfTheOneAndOnlyFaceUpCard​.В противном случае это будет ​false​.
            }
        }
    }
    
    //MARK: - Initializers
    
    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    //MARK: - Public methods
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.matchBonus
                } else {
                    
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchIndex) {
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                score -= timePenalty
                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            dateClick = Date()
        }
    }
    
    mutating func resetGame() {
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
    }
    
}

//MARK: - Extensions

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension Date {
    var sinceNow: Int {
        return -Int(self.timeIntervalSinceNow)
    }
}
