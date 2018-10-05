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
        //let newView = UIView()
        let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)
        let label = UILabel(frame: labelRect)
        label.text = "Hello"
        self.addSubview(label)
        
        
        //UIRectFrame(labelRect)
        let testVar = CGFloat.pi
        let path = UIBezierPath(roundedRect: labelRect, cornerRadius: testVar)
        path.lineWidth = 5.0
        UIColor.red.setStroke()
        path.stroke()
    }
    
}
