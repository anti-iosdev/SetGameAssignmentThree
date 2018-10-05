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
    private lazy var centerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        // 0 means it wont get cut off
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel, index: Int) {
        label.attributedText = centeredAttributedString(String(index), fontSize: CGFloat(30))
        label.frame.size = CGSize.zero
        label.sizeToFit()
        // label.isHidden = !isFaceUp
    }
    
    
    // Init the labels
    override func layoutSubviews() {
        super.layoutSubviews()
        cardGrid.cellCount = Consts.cellCount
        
        for index in 0..<cardGrid.cellCount {
            configureCornerLabel(centerLabel, index: index)
            centerLabel.frame.origin = (cardGrid[index]?.origin)!
        }

    }
    
    override func draw(_ rect: CGRect) {
        
        for index in 0..<cardGrid.cellCount {
            if let cell = cardGrid[index] {
                //let label = UILabel(frame: cell)
                //label.text = String(index)
                //label.attributedText = centeredAttributedString(String(index), fontSize: CGFloat(15))
                //self.addSubview(label)
                
                let path = UIBezierPath(rect: cell)
                // path.addClip()
                path.lineWidth = 2.0
                UIColor.blue.setStroke()
                path.stroke()
            }
        }
        
    }
}

extension SetCardView {
    private struct Consts {
        static let cardAspectRatio: CGFloat = 1/1.586
        static let cellCount: Int = 1
    }
}
