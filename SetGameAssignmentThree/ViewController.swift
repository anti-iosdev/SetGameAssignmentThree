//
//  ViewController.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //lazy var game = SetGame(numberOfTotalSlots: 12)
    var deck = SetCardDeck()

    lazy var cards = shuffledDeck()
    
    func shuffledDeck() -> [SetCard] {
        var cards = [SetCard]()
        for _ in deck.cards.indices {
            if let appendedCard = deck.draw() {
                cards.append(appendedCard)
            }
        }
        return cards
    }
    
    /////
    
    @IBOutlet weak var setCardView: SetCardView! {
        didSet {
            setCardView.deck = cards
        }
    }
    
    func touchCard(_ sender: UIButton) {
        if let cardNumber = setCardView.cardButtons.index(of: sender) {
            print("card index = \(cardNumber)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }


}

