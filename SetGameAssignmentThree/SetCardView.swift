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
    
    func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        // required for scaled fonts
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle,.font:font])
    }
    
    override func draw(_ rect: CGRect) {
        
        let layoutTest = Grid.Layout.aspectRatio(Consts.cardAspectRatio)
        var gridTest = Grid(layout: layoutTest, frame: rect)
        
        gridTest.cellCount = 1
        
        for index in 0..<gridTest.cellCount {
            if let cell = gridTest[index] {
                let label = UILabel(frame: cell)
                label.text = String(index)
                //label.attributedText = centeredAttributedString(String(index), fontSize: CGFloat(15))
                self.addSubview(label)
                
                let path = UIBezierPath(rect: cell)
                path.addClip()
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
    }
}
