//
//  SetCardView.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    
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
    
    func drawCircle(_ cellRect: CGRect) {
        let center = CGPoint(x: cellRect.midX, y: cellRect.midY)
        let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = 1.0
        UIColor.blue.setStroke()
        UIColor.white.setFill()
        path.stroke()
        path.fill()
    }
    
    func drawStripes(_ cellRect: CGRect) {
        //let center = CGPoint(x: cellRect.midX-shapeSize, y: cellRect.midY-shapeSize/2)
        let stripeRect = CGRect(x: cellRect.midX-shapeSize*1.1, y: cellRect.midY-shapeSize/3, width: 2*shapeSize*1.1, height: shapeSize/1.5)
        let path = UIBezierPath(rect: stripeRect)
        path.lineWidth = 5.0
        UIColor.red.setStroke()
        path.stroke()
    }
    
    func drawFourStripes(_ cellRect: CGRect) {
        //let center = CGPoint(x: cellRect.midX-shapeSize, y: cellRect.midY-shapeSize/2)
        var stripeRect = CGRect(x: cellRect.minX, y: cellRect.minY, width: cellRect.width, height: cellRect.height/2)
        let path = UIBezierPath(rect: stripeRect)
        path.lineWidth = 1.0
        UIColor.blue.setStroke()
        path.stroke()
        
        stripeRect = CGRect(x: cellRect.minX, y: cellRect.midY-shapeSize/2, width: cellRect.width, height: shapeSize)
        let path2 = UIBezierPath(rect: stripeRect)
        path2.lineWidth = 1.0
        UIColor.blue.setStroke()
        path2.stroke()
    }
    
    func drawStripedCircle(_ cellRect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: cellRect.midX, y: cellRect.midY)
        let path = UIBezierPath(arcCenter: center, radius: shapeSize, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        //path.lineWidth = 1.0
        context!.saveGState()
        path.addClip()
        UIColor.blue.setStroke()
        UIColor.white.setFill()
        path.fill()
        drawFourStripes(cellRect)
        UIColor.black.setStroke()
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    func drawSquare(_ cellRect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let drawnRect = CGRect(x: cellRect.minX+cellRect.width/4, y: cellRect.minY, width: cellRect.width-cellRect.width/2, height: cellRect.height)
        
        let path = UIBezierPath(rect: drawnRect)
        
        context!.saveGState()
        path.addClip()
        UIColor.blue.setStroke()
        UIColor.white.setFill()
        path.fill()
        //drawFourStripes(cellRect)
        UIColor.black.setStroke()
        path.lineWidth = 3.0
        path.stroke()
        context!.restoreGState()
    }
    
    //////////////////////////
    // Gridding Logic
    
    func cellGridRect(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.minX+rect.width/4, y: rect.minY, width: rect.width-rect.width/2, height: rect.height)
    }
    
    func cellGridDraw(_ rect: CGRect, row: Int) {
        let cellGridLayout = Grid.Layout.dimensions(rowCount: row, columnCount: 1)
        let cellGridRectangle = cellGridRect(rect)
        let cellGrid = Grid(layout: cellGridLayout, frame: cellGridRectangle)
        
        for cell in 0..<cellGrid.cellCount {
            if let cellGridCell = cellGrid[cell] {
                drawStripedCircle(cellGridCell)
            }
        }
    }
    
    //////////////////////////
    
    override func draw(_ rect: CGRect) {
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                let path = UIBezierPath(rect: cell)
                // path.addClip()
                path.lineWidth = 1.0
                UIColor.blue.setStroke()
                path.stroke()
                //drawCircle(cell)
                //drawStripedCircle(cell)
                //drawSquare(cell)
                cellGridDraw(cell, row: 2)
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
}
