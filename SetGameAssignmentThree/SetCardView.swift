//
//  SetCardView.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

@objc protocol AnswerDelegate {
    // Method used to tell the delegate that the button was pressed in the subview.
    // You can add parameters here as you like.
    func buttonWasPressed()
}

class SetCardView: UIView {
    
    /////////////////////////////////////////////////////////////////////////////////
    
    var answerDelegate: AnswerDelegate?
    
    var button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    // Once your view & button has been initialized, configure the button's target.
    func configureButton() {
        //print("configureButton()")
        button.backgroundColor = UIColor.green
        button.setTitle("goddammit", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        // Set your target
        button.addTarget(self, action: #selector(someButtonPressed), for: .touchUpInside)
        addSubview(button)
    }
    
    @objc func someButtonPressed(_ sender: UIButton) {
        //print("delegate")
        answerDelegate?.buttonWasPressed()
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    
    // Essential Definitions
    var deck = [SetCard]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
 
    let cardGridLayout = Grid.Layout.aspectRatio(Consts.cardAspectRatio)
    lazy var cardGrid = Grid(layout: cardGridLayout, frame: bounds)
    
    // Init the labels
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // removes subviews from the superview
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        // initialize the Grid whenever the layout changes
        cardGrid = Grid(layout: cardGridLayout, frame: bounds)
        cardGrid.cellCount = Consts.cellCount
        
        /////////////////////////////////////////////
        configureButton()
        
//        let button2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button2.backgroundColor = UIColor.green
//        button2.setTitle("goddammit", for: UIControl.State.normal)
//        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        addSubview(button2)
    }

    //-------------------------------------------------------------
    // Refactored Code
    
    /////////////////////////////////////////////
    // Defining Variables
    var currentIndex: Int? {
        didSet {
            if let index = currentIndex {
                currentCard = deck[index]
                currentCardCell = cardGrid[index]
            }
        }
    }
    
    //-------------------------------------------------------------
    // Test Code
    
    var cardButtons = [UIButton]()

    /*
             let testingBounds = setCardView.bounds
             let button = UIButton(frame: testingBounds)
             button.backgroundColor = UIColor.green
             button.setTitle("goddammit", for: UIControl.State.normal)
             button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
 
    */
    
    private func createUIButton(_ rect: CGRect) -> UIButton {
        let button = UIButton(frame: rect)
        button.backgroundColor = UIColor.green
        button.setTitle("goddammit", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.addSubview(button)
        //print("\(button)")
        return button
    }

    @objc func buttonAction(sender: UIButton!) {
        //print("Button Tapped!")
    }
    
    func getCardButtons() -> [UIButton] {
        return cardButtons
    }
    
    //var cardButtonGrid = [CGRect]()
    
    //-------------------------------------------------------------
    
    // set after currentIndex is set
    var cardCellMiniGridLayout: Grid.Layout?
    var currentCard: SetCard? {
        didSet {
            if let card = currentCard {
                cardCellMiniGridLayout = Grid.Layout.dimensions(rowCount: card.number.rawValue, columnCount: 1)
            }
        }
    }
    var currentCardCell: CGRect? {
        didSet {
            if let rect = currentCardCell {
                cardCellMini = cardCellMiniConverter(rect)
                cardButtons.append(createUIButton(rect))
                //cardButtonGrid.append(rect)
            }
        }
    }
    var cardCellMini: CGRect? {
        didSet {
            if let layout = cardCellMiniGridLayout, let cardCell = cardCellMini {
                cardCellMiniGrid = Grid(layout: layout, frame: cardCell)
            }
        }
    }
    var cardCellMiniGrid: Grid?
    
    func cardCellMiniConverter(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.minX+rect.width/4, y: rect.minY, width: rect.width-rect.width/2, height: rect.height)
    }
    
    /////////////////////////////////////////////
    // Drawing Logic
    func drawStripes(_ cellRect: CGRect) {
        //let center = CGPoint(x: cellRect.midX-shapeSize, y: cellRect.midY-shapeSize/2)
        let width = cellRect.width*1.4
        var stripeRect = CGRect(x: cellRect.minX-width*0.2, y: cellRect.minY, width: width, height: cellRect.height/2)
        let path = UIBezierPath(rect: stripeRect)
        path.lineWidth = 2.0
        //UIColor.blue.setStroke()
        path.stroke()
        
        stripeRect = CGRect(x: cellRect.minX-width*0.2, y: cellRect.midY-shapeSize/2, width: width, height: shapeSize)
        let path2 = UIBezierPath(rect: stripeRect)
        path2.lineWidth = 2.0
        //UIColor.blue.setStroke()
        path2.stroke()
    }
    
    func drawShading(_ path: UIBezierPath, rect: CGRect) {
        // check shading for cases: 1 = empty, 2 = fill, 3 = striped
        if let card = currentCard {
            let shading = card.shading.result
            if shading == 1 {
                UIColor.white.setFill()
                path.fill()
                card.color.result.setStroke()
            } else if shading == 2 {
                card.color.result.setFill()
                path.fill()
                //UIColor.black.setStroke()
                card.color.result.setStroke()
            } else if shading == 3 {
                UIColor.white.setFill()
                path.fill()
                card.color.result.setStroke()
                drawStripes(rect)
                //UIColor.black.setStroke()
            }
        }
    }
    
    func drawSquare(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.midX-squareSize/2, y: rect.midY-squareSize/2)
        let sizeRect = CGSize(width: squareSize, height: squareSize)
        let drawnRect = CGRect(origin: center, size: sizeRect)
        
        let path = UIBezierPath(rect: drawnRect)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        drawShading(path, rect: rect)
        
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func drawCircle(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        drawShading(path, rect: rect)
        
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func drawSquiggle(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        // defining the circles
        let centerSemiOne = CGPoint(x: rect.midX+shapeSize/2, y: rect.midY)
        let centerSemiTwo = CGPoint(x: rect.midX-shapeSize/2, y: rect.midY)
        
        let pathSemiOne = UIBezierPath(arcCenter: centerSemiOne, radius: shapeSize, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let pathSemiTwo = UIBezierPath(arcCenter: centerSemiTwo, radius: shapeSize, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        
        let path = pathSemiOne
        path.append(pathSemiTwo)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        drawShading(path, rect: rect)
        
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func drawDiamond(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.midX-squareSize/2, y: rect.midY-squareSize/2)
        let sizeRect = CGSize(width: squareSize, height: squareSize)
        let drawnRect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizeRect)
        
        let path = UIBezierPath(rect: drawnRect)
        
        let diagonalHalf = squareSize/2
        let pathRotation = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        let pathTranslation2 = CGAffineTransform(translationX: center.x, y: center.y)
        let pathTranslation3 = CGAffineTransform(translationX: diagonalHalf, y: -diagonalHalf/2.5)
        
        path.apply(pathRotation)
        path.apply(pathTranslation2)
        path.apply(pathTranslation3)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        drawShading(path, rect: rect)
        
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func drawOval(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let width = squareSize*1.5
        let center = CGPoint(x: rect.midX-width/2, y: rect.midY-squareSize/2)
        let sizeRect = CGSize(width: squareSize*1.5, height: squareSize)
        let drawnRect = CGRect(origin: center, size: sizeRect)
        
        let path = UIBezierPath(ovalIn: drawnRect)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        drawShading(path, rect: rect)
        
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func masterDrawFunction() {
        if let card = currentCard, let cardGrid = cardCellMiniGrid {
            for index in 0..<cardGrid.cellCount {
                if let rect = cardGrid[index] {
                    if card.symbol.match == 1 {
                        drawSquiggle(rect)
                    } else if card.symbol.match == 2 {
                        drawDiamond(rect)
                    } else if card.symbol.match == 3 {
                        drawOval(rect)
                    }
                }
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    //-------------------------------------------------------------
    // Drawing Step
    
    override func draw(_ rect: CGRect) {
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                // draw in the grid
                let path = UIBezierPath(rect: cell)
                path.lineWidth = 2.0
                UIColor.gray.setStroke()
                path.stroke()
//
//                // draw shapes in the grid
                currentIndex = index
                masterDrawFunction()
            }
        }
        
    }
    
}

extension SetCardView {
    private struct Consts {
        static let cellCount: Int = 81
        static let cardAspectRatio: CGFloat = 1/1.586
        static let centerFontSizeToBoundsHeight: CGFloat = 0.4
        static let shapeRatio: CGFloat = 0.2
    }
    private var centerFontSize: CGFloat {
        return cardGrid.cellSize.height * Consts.centerFontSizeToBoundsHeight
    }
    private var shapeSize: CGFloat {
        return cardGrid.cellSize.width * Consts.shapeRatio
    }
    private var squareSize: CGFloat {
        return shapeSize*1.5
    }
}
