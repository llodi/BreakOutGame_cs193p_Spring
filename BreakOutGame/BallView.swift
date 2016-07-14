//
//  BallView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    var balls = [String:UIBezierPath]() { didSet{ setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in balls {
            path.stroke()
        }
    }
    
}
