//
//  GameView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var paddle: UIView?
    
    struct ViewConstant {
        static let PaddleHeight: CGFloat = 12.0
    }
    
    var balls = BallView()
    
    private var paddleSize: CGSize {
        let paddleWidth = ViewConstant.PaddleHeight * 5
        return CGSize(width: paddleWidth, height: ViewConstant.PaddleHeight)
    }
    
    private func setInitialPaddlePosition() {
        
        if paddle == nil {
            let originY = bounds.maxY - ViewConstant.PaddleHeight * 3
            let origin = CGPoint(x: bounds.midX, y: originY)
            let frame = CGRect(origin: origin, size: paddleSize)
            
            paddle = UIView(frame: frame)
            paddle!.backgroundColor = UIColor.blueColor()
            addSubview(paddle!)
        }
    }
    
    private func setInitialBallPosition() {
        
        let path = UIBezierPath(ovalInRect: CGRect(origin: CGPoint(x: 35, y: 233), size: CGSize(width: 5.0, height: 5.0)))
        balls.balls["1"] = path

    }
    
    
    override func layoutSubviews() {
        setInitialPaddlePosition()
        setInitialBallPosition()
    }
    
    private func movePadleTo(point: CGPoint) {
        
        if let pad = paddle {
            let y = pad.frame.origin.y
            if point.x + pad.frame.size.width >=
                bounds.maxX { return }
            
            let origin = CGPoint(x: point.x, y: y)
            pad.frame.origin = origin
        }
    }
    
   
    func grubPaddle(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.locationInView(self)
        switch recognizer.state {
        case .Ended,.Changed:
            movePadleTo(point)
        default:
            break
        }
    }

}
