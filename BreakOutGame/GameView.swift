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
        removeBall()
    }
    
    var bricks = [[BrickView?]]()
    
    var brickSize: CGSize {
        let offsetCount = CGFloat(bricksBetweenSpacing) * CGFloat(ViewConstant.BricksPerRow + 1)
        let width = (bounds.size.width - offsetCount) /
            CGFloat(ViewConstant.BricksPerRow)
        return CGSize(width: width, height: ViewConstant.PaddleHeight)
    }
    
    private var brickRowYPosition: CGFloat = 80.0
    
    var bricksLine = 0
    var bricksBetweenSpacing: CGFloat = 0.0
    
    func addBricks() {
        for i in 1...bricksLine {
            addBricksInRow(brickRowYPosition, withRowId: i * 10)
            brickRowYPosition += CGFloat(bricksBetweenSpacing) + ViewConstant.PaddleHeight
        }
    }
    
    private func addBricksInRow(atPoint: CGFloat, withRowId: Int) {
        
        var x = CGFloat(bricksBetweenSpacing)
        var bricks_ = [BrickView?]()
        for i in 1...ViewConstant.BricksPerRow
        {
            let frame = CGRect(origin: CGPoint(x: x, y: brickRowYPosition), size:  brickSize)
            let brick = BrickView(frame: frame)
            addSubview(brick)
            x += brickSize.width + CGFloat(bricksBetweenSpacing)
            breakoutBehaviour.addViewBarrier(brick.path!, named: i + withRowId)
            bricks_.append(brick)
        }
        bricks.append(bricks_)
    }
    
    private func addOneBoundary(from from_: CGPoint, to to_: CGPoint) -> UIBezierPath {
        let line = UIBezierPath()
        line.moveToPoint(from_)
        line.addLineToPoint(to_)
        return line
    }
    
    func addMainViewBoundaries() {
        let topLetfPoint = CGPoint(x: bounds.origin.x, y: bounds.origin.y)
        let topRightPoint = CGPoint(x: bounds.size.width, y: bounds.origin.y)
        let bottomLeftPoint = CGPoint(x: bounds.origin.x, y: bounds.size.height)
        let bottomRightPoint = CGPoint(x: bounds.size.width, y: bounds.size.height)
        
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topLetfPoint, to: bottomLeftPoint), named: ViewConstant.LeftBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topRightPoint, to: bottomRightPoint), named: ViewConstant.RightBoundaryName)
        breakoutBehaviour.addViewBarrier(addOneBoundary(
            from: topLetfPoint, to: topRightPoint), named: ViewConstant.TopBoundaryName)
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
        //static let BrickOffset: CGFloat = 5.0
        static let BricksPerRow = 7
    }
    
    private var ball: BallView?
    
    func addBall(recognizer: UITapGestureRecognizer) {
        
        if recognizer.state == .Ended {
            if ball == nil {
                ball = BallView(frame: CGRect(origin: CGPoint(x: bounds.midX,
                    y: bounds.midY),
                    size: ViewConstant.BallSize))
                addSubview(ball!)
                breakoutBehaviour.addBallBehaviour(ball!)
                breakoutBehaviour.addViewBarrier(UIBezierPath(ovalInRect: paddle!.frame), named: ViewConstant.PaddleBoundaryName)
            }
        }
    }
    
    func removeBall() {
        breakoutBehaviour.removeItem(ball!)
        ball?.removeFromSuperview()
    }
    
    func removeBrick(brick: BrickView) {
        breakoutBehaviour.removeItem(brick)
        brick.removeFromSuperview()
    }
    
    private var paddleSize: CGSize {
        let paddleWidth = ViewConstant.PaddleHeight * ViewConstant.PaddleWidthFactor
        return CGSize(width: paddleWidth, height: ViewConstant.PaddleHeight)
    }
    
    func setInitialPaddlePosition() {
        
        if paddle == nil {
            let originY = bounds.maxY - ViewConstant.PaddleHeight * 5
            let origin = CGPoint(x: bounds.midX, y: originY)
            let frame = CGRect(origin: origin, size: paddleSize)
            
            paddle = UIView(frame: frame)
            paddle!.backgroundColor = UIColor.blueColor()
            addSubview(paddle!)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //logVCL("layoutSubviews() self.bounds.size = \(self.bounds.size) - superview bounds.size = \(superview?.bounds.size ?? CGSize.zero)")
        addMainViewBoundaries()
        breakoutBehaviour.collider.collisionDelegate = self
//        print("\(bounds.size.width) subview width view layout")
//        print("\(superview?.bounds.size.width) superview width view layout")
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        let id = identifier as? String
        if id == ViewConstant.BottomBoundaryName {
            print ("OUT! GAME OVER!!")
            animating = false            
        } else if let id = identifier as? Int {
            if let b = bricks[Int(id/10) - 1][Int(id%10) - 1] {
                b.removeFromSuperview()
                print("Strike on \(id)")
            }

        }
    }
    
    private func movePaddleTo(point: CGPoint) {
        if let pad = paddle {
            var newFrame = pad.frame
            newFrame.origin.x = max(min(newFrame.origin.x + point.x, bounds.maxX - point.x - pad.bounds.size.height), 0.0)
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
