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
    var deck = SetCardDeck()
    var test = [CGRect]()
    
    func buttonWasPressed() {
        // UIViewController can handle SomeView's button press.
        print("uiviewcontroller was accessed")
        //print("\(setCardView.cardGrid.cellCount)")
        print("The currently selected card: \(setCardView.selectedButtonIndex!)")
    }
    
    

    
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
    
    @IBOutlet weak var setCardView: SetCardView! {
        didSet {
            setCardView.deck = cards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCardView.answerDelegate = self

    }
}

