//
//  GameView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class GameView: UIView {
    
  
    var breakoutBehaviour = BreakOutBehavior()
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)        
        return animator
    }()
    
    var animating: Bool = false {
        didSet {
            if animating {
                animator.addBehavior(breakoutBehaviour)
            } else {
                animator.removeBehavior(breakoutBehaviour)
            }
        }
    }
    
    private func addOneBoundary(from from_: CGPoint, to to_: CGPoint) -> UIBezierPath {
        let line = UIBezierPath()
        line.moveToPoint(from_)
        line.addLineToPoint(to_)
        return line
    }
    
    private func addMainViewBoundaries() {
        let topLetfPoint = CGPoint(x: bounds.origin.x, y: bounds.origin.y)
        let topRightPoint = CGPoint(x: bounds.size.width, y: bounds.origin.y)
        let bottomLeftPoint = CGPoint(x: bounds.origin.x, y: bounds.size.height)
        let bottomRightPoint = CGPoint(x: bounds.size.width, y: bounds.size.height)
        
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topLetfPoint, to: bottomLeftPoint), named: ViewConstant.leftBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topRightPoint, to: bottomRightPoint), named: ViewConstant.rightBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topLetfPoint, to: topLetfPoint), named: ViewConstant.topBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: bottomLeftPoint, to: bottomRightPoint), named: "bottom")
    }
    
    var paddle: UIView?
    
    struct ViewConstant {
        static let PaddleHeight: CGFloat = 12.0
        static let PaddleWidthFactor: CGFloat = 5.0
        static let BallSize = CGSize(width: 12.0, height: 12.0)
        static let leftBoundaryName = "Left Boundary"
        static let rightBoundaryName = "Right Boundary"
        static let topBoundaryName = "Top Boundary"
        static let paddleBoundaryName = "Paddle"
    }
    
    var ball: BallView?
    
    func addBall(recognizer: UITapGestureRecognizer) {
        
        if recognizer.state == .Ended {
            if ball == nil {
                ball = BallView(frame: CGRect(origin: CGPoint(x: bounds.midX,
                    y: bounds.midY),
                    size: ViewConstant.BallSize))
                addSubview(ball!)
                breakoutBehaviour.addItem(ball!)
                //breakoutBehaviour.addViewBarrier(ball, named: <#T##String#>)
            }
        }
    }
    
    private var paddleSize: CGSize {
        let paddleWidth = ViewConstant.PaddleHeight * ViewConstant.PaddleWidthFactor
        return CGSize(width: paddleWidth, height: ViewConstant.PaddleHeight)
    }
    
    func setInitialPaddlePosition() {
        
        if paddle == nil {
            let originY = bounds.maxY - ViewConstant.PaddleHeight * 2
            let origin = CGPoint(x: bounds.midX, y: originY)
            let frame = CGRect(origin: origin, size: paddleSize)
            
            paddle = UIView(frame: frame)
            paddle!.backgroundColor = UIColor.blueColor()
            addSubview(paddle!)
        }
    }
    
   
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func movePadleTo(point: CGPoint) {
        if let pad = paddle {
            var newFrame = pad.frame
            newFrame.origin.x = max(min(newFrame.origin.x + point.x, bounds.maxX - point.x), 0.0)
            pad.frame = newFrame
            breakoutBehaviour.addViewBarrier(UIBezierPath(ovalInRect: paddle!.frame), named: ViewConstant.paddleBoundaryName)
        }
        
//        if let pad = paddle {
//            let y = pad.frame.origin.y
//            if point.x + pad.frame.size.width >=
//                bounds.maxX { return }
//            
//            let origin = CGPoint(x: point.x, y: y)
//            pad.frame.origin = origin
//        }
    }
    
    func grubPaddle(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.translationInView(self)
        //recognizer.locationInView(self)
        switch recognizer.state {
        case .Ended,.Changed:
            movePadleTo(point)
            recognizer.setTranslation(CGPointZero, inView: self)
        default:
            break
        }
    }

}
