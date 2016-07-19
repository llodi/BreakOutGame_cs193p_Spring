//
//  BrickView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 15.07.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BrickView: UIView {

    
    struct BrickViewConsts {
        static let LineWidth: CGFloat = 3.0
    }
    
    var brickCornerRadius: CGFloat = 7.0
    
    //var path: UIBezierPath?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        //path = UIBezierPath(roundedRect: self.bounds, cornerRadius: brickCornerRadius)
        self.backgroundColor = UIColor.redColor()
        self.layer.cornerRadius = brickCornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func drawRect(rect: CGRect) {
//        
//        path?.stroke()
//    }
}
