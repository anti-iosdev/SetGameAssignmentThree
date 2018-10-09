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

    /////
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
    
    /////
    
    // dummy card (working)
    // var card = SetCard(number: SetCard.Number.one, color: SetCard.Color.one)
    
//    let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
//    let label = UILabel(frame: labelRect)
//    label.text = "Hello"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //let newView = UIView()
//        let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
//        let label = UILabel(frame: labelRect)
//        label.text = "Hello"
//        view.addSubview(label)
    }


}

