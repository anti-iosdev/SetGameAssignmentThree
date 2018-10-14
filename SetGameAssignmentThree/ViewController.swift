//
//  ViewController.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AnswerDelegate {

    //lazy var someView = setCardView
    
    func buttonWasPressed() {
        // UIViewController can handle SomeView's button press.
        print("uiviewcontroller was accessed")
        print("\(setCardView.cardGrid.cellCount)")
    }
    
    
    var deck = SetCardDeck()
    
    var test = [CGRect]()
    
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
        //self.view.addSubview(setCardView)
        //setCardView.bringSubviewToFront(setCardView)
//        let testingBounds = setCardView.bounds
//        let button = UIButton(frame: testingBounds)
//        button.backgroundColor = UIColor.green
//        button.setTitle("goddammit", for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button Tapped! in uiviewcontroller")
    }


}

