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
        
        cardGrid = Grid(layout: cardGridLayout, frame: bounds)
        cardGrid.cellCount = Consts.cellCount
        
        var labelArray = [UILabel]()
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                let cardLabel = createCenterLabel(cell)
                labelArray.append(cardLabel)
            }
        }
        for index in labelArray.indices {
            let label = labelArray.removeFirst()
            configureCenterLabel(label, index: index)
            label.frame.origin = (cardGrid[index]?.origin)!
        }
        
        
//        for _ in 0..<cardGrid.cellCount {
//            let cardLabel = createCenterLabel()
//            labelArray.append(cardLabel)
//        }
//        for index in labelArray.indices {
//            let label = labelArray.removeFirst()
//            configureCenterLabel(label, index: index)
//            label.frame.origin = (cardGrid[index]?.origin)!
//        }
        
//        for index in 0..<cardGrid.cellCount {
//            configureCornerLabel(centerLabel, index: index)
//            centerLabel.frame.origin = (cardGrid[index]?.origin)!
//        }

    }
    
    override func draw(_ rect: CGRect) {
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                let path = UIBezierPath(rect: cell)
                // path.addClip()
                path.lineWidth = 1.0
                UIColor.blue.setStroke()
                path.stroke()
            }
        }
    }
}

extension SetCardView {
    private struct Consts {
        static let cardAspectRatio: CGFloat = 1/1.586
        static let cellCount: Int = 12
        static let centerFontSizeToBoundsHeight: CGFloat = 0.4
    }
    private var centerFontSize: CGFloat {
        return cardGrid.cellSize.height * Consts.centerFontSizeToBoundsHeight
    }
}
