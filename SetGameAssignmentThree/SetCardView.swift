//
//  SetCardView.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
//    let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
//    let label = UILabel(frame: labelRect)
//    label.text = "Hello"
//    view.addSubview(SetCardView)

    
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//        path.lineWidth = 5.0
//        UIColor.green.setFill()
//        UIColor.red.setStroke()
    //        path.stroke()
    //        path.fill()
    //    }
    //let newView = UIView()

    
    override func draw(_ rect: CGRect) {
        
        func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
            var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
            // required for scaled fonts
            font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle,.font:font])
        }
        
        let layoutTest = Grid.Layout.aspectRatio(CGFloat(1/1.586))
        var gridTest = Grid(layout: layoutTest, frame: rect)
        
        gridTest.cellCount = 81
        
        for index in 0..<gridTest.cellCount {
            if let cell = gridTest[index] {
                let label = UILabel(frame: cell)
                label.text = String(index)
                label.attributedText = centeredAttributedString(String(index), fontSize: CGFloat(15))
                self.addSubview(label)
                
                let path = UIBezierPath(rect: cell)
                path.lineWidth = 2.0
                UIColor.blue.setStroke()
                path.stroke()
            }
        }
        
        
        /* Spawns a red rectangle with a label in it
        let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
        let label = UILabel(frame: labelRect)
        label.text = "Hello"
        self.addSubview(label)
        
        let testVar = CGFloat.pi
        let path = UIBezierPath(roundedRect: labelRect, cornerRadius: testVar)
        path.lineWidth = 5.0
        UIColor.red.setStroke()
        path.stroke()
        */
        
    }
    
}