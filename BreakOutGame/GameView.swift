//
//  GameView.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class GameView: UIView, UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate {
    
  
    var breakoutBehaviour = BreakOutBehavior()
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
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
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        //removeBall()
    }
    
//    var bricks = [[UIView?]]()
//    
//    var brickSize: CGSize {
//        //let offsets = ViewConstant.BrickOffset * CGFloat(ViewConstant.BricksPerRow + 1)
//        //let widthWithoutOffsets = bounds.size.width - offsets
//        let width = bounds.size.width / CGFloat(ViewConstant.BricksPerRow)
//        print("\(bounds.size.width)")
//        return CGSize(width: width, height: ViewConstant.PaddleHeight)
//    }
//    
//    func addBricksInRow() {
//        var x = ViewConstant.BrickOffset
//        for _ in 1...1//ViewConstant.BricksPerRow
//        {
//            let frame = CGRect(origin: CGPoint(x: x, y: ViewConstant.BrickInitialYPosition), size:  brickSize)
//            let brick = UIView(frame: frame)
//            brick.backgroundColor = UIColor.random
//            addSubview(brick)
//            x 	= brickSize.width + ViewConstant.BrickOffset * 2
//        }
//    }
    
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
            from: topLetfPoint, to: bottomLeftPoint), named: ViewConstant.LeftBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topRightPoint, to: bottomRightPoint), named: ViewConstant.RightBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topLetfPoint, to: topLetfPoint), named: ViewConstant.TopBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: bottomLeftPoint, to: bottomRightPoint), named: ViewConstant.BottomBoundaryName)
    }
    
    var paddle: UIView?
    
    struct ViewConstant {
        static let PaddleHeight: CGFloat = 12.0
        static let PaddleWidthFactor: CGFloat = 5.0
        static let BallSize = CGSize(width: 12.0, height: 12.0)
        static let LeftBoundaryName = "Left Boundary"
        static let RightBoundaryName = "Right Boundary"
        static let TopBoundaryName = "Top Boundary"
        static let BottomBoundaryName = "Bottom Boundary"
        static let PaddleBoundaryName = "Paddle"
        static let BrickOffset: CGFloat = 2.0
        static let BricksPerRow = 5
        static let BrickInitialYPosition: CGFloat = 30.0
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
            }
        }
    }
    
    func removeBall() {
        breakoutBehaviour.removeItem(ball!)
        ball?.removeFromSuperview()
    }
    
    private var paddleSize: CGSize {
        let paddleWidth = ViewConstant.PaddleHeight * ViewConstant.PaddleWidthFactor
        return CGSize(width: paddleWidth, height: ViewConstant.PaddleHeight)
    }
    
    func setInitialPaddlePosition() {
        
        print("\(bounds.size.width)")
        
        if paddle == nil {
            let originY = bounds.maxY - ViewConstant.PaddleHeight * 2
            let origin = CGPoint(x: bounds.midX, y: originY)
            let frame = CGRect(origin: origin, size: paddleSize)
            
            paddle = UIView(frame: frame)
            paddle!.backgroundColor = UIColor.blueColor()
            print("\(paddle?.frame.origin) paddle")
            addSubview(paddle!)
        }
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        //addMainViewBoundaries()
        //breakoutBehaviour.collider.collisionDelegate = self
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        let id = identifier as? String
        if id == ViewConstant.BottomBoundaryName {
            print ("OUT! GAME OVER!!")
            animating = false            
        }
        
    }
    
    private func movePaddleTo(point: CGPoint) {
        if let pad = paddle {
            var newFrame = pad.frame
            newFrame.origin.x = max(min(newFrame.origin.x + point.x, bounds.maxX - point.x), 0.0)
            pad.frame = newFrame
            breakoutBehaviour.addViewBarrier(UIBezierPath(ovalInRect: paddle!.frame), named: ViewConstant.PaddleBoundaryName)
        }
    }
    
    func grubPaddle(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.translationInView(self)
        switch recognizer.state {
        case .Ended,.Changed:
            movePaddleTo(point)
            recognizer.setTranslation(CGPointZero, inView: self)
        default:
            break
        }
    }

}
