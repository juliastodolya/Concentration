//
//  ViewController.swift
//  Concentration
//
//  Created by Юлия on 27.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var themeLabel: UILabel!
    
    @IBOutlet var newGameButton: UIButton!
    
    @IBOutlet private var flipCountLabel: UILabel!
    
    @IBOutlet var scoreCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    private struct Theme {
        var name: String
        var emojis: [String]
        var viewColor: UIColor
        var cardColor: UIColor
    }
    
    private var emojiThemes: [Theme] = [
        Theme(name: "Halloween", emojis: ["🎃", "👻", "💀", "🦇", "🕸", "🧛🏻‍♂️", "🍭", "🌕", "🐺", "🧟‍♀️"], viewColor: .black, cardColor: .orange),
        Theme(name: "Christmas", emojis: ["🎅", "🎄", "❄️", "⛄️", "🍾", "🎁", "🎈", "🎉", "👨‍👩‍👧‍👦", "🛷"], viewColor: .white, cardColor: .blue),
        Theme(name: "Food", emojis: ["🍕", "🍣", "🍩", "🍔", "🥗", "🍰", "🍜", "🥡", "🧀", "🥐"], viewColor: .yellow, cardColor: .red),
        Theme(name: "Sport", emojis: ["⚽️", "🏂", "🚴‍♀️", "🏸", "🥊", "🤺", "🧘‍♀️", "🚣", "🤼‍♂️", "🏀"], viewColor: .lightGray, cardColor: .black),
        Theme(name: "Animals", emojis: ["🐱", "🐶", "🐼", "🐸", "🦊", "🐥", "🐍", "🦦", "🦩", "🐙"], viewColor: .green, cardColor: .yellow),
        Theme(name: "Clothes", emojis: ["🧥", "👙", "👗", "👠", "🕶", "🧤", "🧦", "👔", "🦺", "🧢"], viewColor: .systemPink, cardColor: .white)
    ]
    
    private var emojiChoices = [String] ()
    private var backgroundColor = UIColor.black
    private var cardBackColor = UIColor.orange
    
    private var indexTheme = 0 {
        didSet {
            themeLabel.text = emojiThemes[indexTheme].name
            emoji = [Int: String]()
            emojiChoices = emojiThemes[indexTheme].emojis
            
            backgroundColor = emojiThemes[indexTheme].viewColor
            cardBackColor = emojiThemes[indexTheme].cardColor
            
            updateAppearance()
        }
    }
        
    private var emoji = [Int: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel​()
        indexTheme = Int.random(in: 0..<emojiThemes.count)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else { return }
        game.chooseCard(at: cardNumber)
        updateViewFromModel​()
    }
    
    @IBAction func newGame() {
        game.resetGame()
        indexTheme = Int.random(in: 0..<emojiThemes.count)
        updateViewFromModel​()
    }
    
    private func updateViewFromModel​() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBackColor
            }
        }
        scoreCountLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
               emoji[card.identifier] = emojiChoices.remove(at: Int.random(in: 0..<emojiChoices.count))
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreCountLabel.textColor = cardBackColor
        themeLabel.textColor = cardBackColor
        newGameButton.setTitleColor(backgroundColor, for: .normal)
        newGameButton.backgroundColor = cardBackColor
    }
}


