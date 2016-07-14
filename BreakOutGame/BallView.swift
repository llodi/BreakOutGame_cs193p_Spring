//
//  BallView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        self.backgroundColor = UIColor.redColor()
        self.layer.cornerRadius = self.frame.width / 2
    }
}
