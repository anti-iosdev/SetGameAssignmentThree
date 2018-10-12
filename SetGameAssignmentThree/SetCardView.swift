//
//  SetCardView.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var deck = [SetCard]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    

    
    //    var card: SetCard = SetCard(number: SetCard.Number.one, color: SetCard.Color.one) { didSet { setNeedsDisplay(); setNeedsLayout() } }
    //    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    
    // Definitions
    let cardGridLayout = Grid.Layout.aspectRatio(Consts.cardAspectRatio) 
    lazy var cardGrid = Grid(layout: cardGridLayout, frame: bounds)
    
    // Drawing the Strings
    func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        // required for scaled fonts
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle,.font:font])
    }
    
    
    // Creating and positioning the text labels
    //private lazy var centerLabel = createCenterLabel()
    
    private func createCenterLabel(_ frame: CGRect) -> UILabel {
        let label = UILabel(frame: frame)
        // 0 means it wont get cut off
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCenterLabel(_ label: UILabel, index: Int) {
        label.attributedText = centeredAttributedString(String(index), fontSize: centerFontSize)
        label.frame.size = CGSize.zero
        label.sizeToFit()
        // label.isHidden = !isFaceUp
    }
    
    
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
        
        func drawIndexes() {
            // setting up the labels
            var labelArray = [UILabel]()
            
            for index in 0..<cardGrid.cellCount {
                if let cell = cardGrid[index] {
                    let cardLabel = createCenterLabel(cell)
                    labelArray.append(cardLabel)
                }
            }
            for index in labelArray.indices {
                if let cellRect = cardGrid[index] {
                    let label = labelArray.removeFirst()
                    configureCenterLabel(label, index: index)
                    label.center = CGPoint(x: cellRect.midX, y: cellRect.midY)
                }
            }
        }
    }
    

    //////////////////////////
    // Drawing Logic
    
    
//    func drawShading(_ path: UIBezierPath, shading: Int) {
//        if shading == 1 {
//            UIColor.white.setFill()
//            path.fill()
//        } else if shading == 2 {
//            card.color.result.setFill()
//            path.fill()
//        } else if shading == 3 {
//            UIColor.white.setFill()
//            path.fill()
//            drawFourStripes(rect)
//        }
//    }
    
//    let context = UIGraphicsGetCurrentContext()
//    let center = CGPoint(x: rect.midX, y: rect.midY)
//    let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//
//    // making sure of clipping
//    context!.saveGState()
//    path.addClip()
//
//
//    drawShading(path, rect: rect)
//
//    path.lineWidth = 3.0
//    path.stroke()
//    context!.restoreGState()
//

    
    func drawCircleTemp(_ rect: CGRect, card: SetCard) {
        // defining shape
        let shading = card.shading.result
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        // making sure of clipping
        context!.saveGState()
        path.addClip()
        
        // check shading for cases: 1 = empty, 2 = fill, 3 = striped
        if shading == 1 {
            UIColor.white.setFill()
            path.fill()
        } else if shading == 2 {
            card.color.result.setFill()
            path.fill()
        } else if shading == 3 {
            UIColor.white.setFill()
            path.fill()
            drawStripes(rect)
        }
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }

    //-------------------------------------------------------------
    // Refactored Code
    
    var currentIndex: Int? {
        didSet {
            if let index = currentIndex {
                currentCard = deck[index]
                currentCardCell = cardGrid[index]
            }
        }
    }
    
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
    
    // functions
    func cardCellMiniConverter(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.minX+rect.width/4, y: rect.minY, width: rect.width-rect.width/2, height: rect.height)
    }
    
    func drawStripes(_ cellRect: CGRect) {
        //let center = CGPoint(x: cellRect.midX-shapeSize, y: cellRect.midY-shapeSize/2)
        let width = cellRect.width*1.3
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
                UIColor.black.setStroke()
            } else if shading == 3 {
                UIColor.white.setFill()
                path.fill()
                card.color.result.setStroke()
                drawStripes(rect)
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
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        //let pathExperiment = UIBezierPath(
        
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
                    
                    //drawSquare(rect)
                    //drawCircle(rect)
                    //drawOval(rect)
                    drawDiamond(rect)
                }
            }
        }
    }
    
    //-------------------------------------------------------------
    // Corner Labels
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        // 0 means it wont get cut off
        // label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        //label.attributedText = cornerString
        // clears its size
        //label.frame =
        label.frame.size = CGSize.zero
        label.sizeToFit()
        //label.isHidden = !isFaceUp
    }
    
    
    //-------------------------------------------------------------

    
    //////////////////////////
    // Gridding Logic
    
    func cellGridRect(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.minX+rect.width/4, y: rect.minY, width: rect.width-rect.width/2, height: rect.height)
    }
    
    func cellGridDraw(_ rect: CGRect, card: SetCard) {
        let cellGridLayout = Grid.Layout.dimensions(rowCount: card.number.rawValue, columnCount: 1)
        let cellGridRectangle = cellGridRect(rect)
        let cellGrid = Grid(layout: cellGridLayout, frame: cellGridRectangle)
        
        card.color.result.setStroke()
        card.color.result.setFill()
        
        for cell in 0..<cellGrid.cellCount {
            if let cellGridCell = cellGrid[cell] {
                drawCircleTemp(cellGridCell, card: card)
            }
        }
    }
    
    func cardDrawer(rect: CGRect, card: SetCard) {
        cellGridDraw(rect, card: card)
    }
    
    
    
    //////////////////////////
    
    override func draw(_ rect: CGRect) {
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                // draw in the grid
                let path = UIBezierPath(rect: cell)
                path.lineWidth = 2.0
                UIColor.gray.setStroke()
                path.stroke()
                
                // draw shapes in the grid
                currentIndex = index
                masterDrawFunction()
            }
        }
    }
}

extension SetCardView {
    private struct Consts {
        static let cellCount: Int = 12
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
