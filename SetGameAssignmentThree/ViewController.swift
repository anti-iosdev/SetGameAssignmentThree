//
//  ViewController.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AnswerDelegate {

    // Essential Definitions
    var game = SetGame(numberOfTotalSlots: 81)
    var deck = SetCardDeck()
    var test = [CGRect]()
    
    func buttonWasPressed() {
        let selectedButtonIndex = setCardView.selectedButtonIndex!
        
        game.chooseCard(at: selectedButtonIndex)
        print("The currently selected card: \(selectedButtonIndex)")
        updateViewFromModel()
    }
    
    lazy var cards = shuffledDeck()
    lazy var cards2 = game.cards
    
    func shuffledDeck() -> [SetCard] {
        var cards = [SetCard]()
        for _ in deck.cards.indices {
            if let appendedCard = deck.draw() {
                cards.append(appendedCard)
            }
        }
        return cards
    }
    
    @IBOutlet weak var setCardView: SetCardView! {
        didSet {
            setCardView.deck = cards2
        }
    }
    
    func updateViewFromModel() {
        setCardView.deck = game.cards
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCardView.answerDelegate = self

    }
}

