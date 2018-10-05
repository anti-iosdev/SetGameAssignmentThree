//
//  SetCard.swift
//  SetGameAssignmentThree
//
//  Created by Anti on 10/3/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import Foundation
import UIKit

struct SetCard
{
    var number: Number
    var color: Color
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [Number.one,.two,.three]
        
        var description: Int { return rawValue }
    }
    
    enum Color {
        case one
        case two
        case three
        
        var result:  UIColor {
            switch self {
            case .one: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .two: return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            case .three: return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
        
        var match: Int {
            switch self {
            case .one: return 1
            case .two: return 2
            case .three: return 3
            }
        }
        
        static var all = [Color.one,.two,.three]
    }
}
