	//
//  GameViewController.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 14/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gameView.addBricksInRow()
        print("\(gameView.bounds.size.width) subview width")
        print("\(view.bounds.size.width) superview width")
        
    }

    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.setInitialPaddlePosition()
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(GameView.grubPaddle(_:))))
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: gameView, action: #selector(GameView.addBall(_:))))
            gameView.backgroundColor = UIColor.yellowColor()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        gameView.animating = false
    }

}
