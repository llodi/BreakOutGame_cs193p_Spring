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
        static let BrickCornerRadius: CGFloat = 2.0
        static let LineWidth: CGFloat = 3.0
    }
    
    var path: UIBezierPath?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        self.layer.cornerRadius = BrickViewConsts.BrickCornerRadius
        path = UIBezierPath(rect: frame)
        self.backgroundColor = UIColor.random
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        path?.lineWidth = BrickViewConsts.LineWidth
        UIColor.redColor().set()
        path?.stroke()
    }
 

}
