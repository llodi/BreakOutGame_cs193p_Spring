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
        logVCL("viewDidLoad() GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
        applaySettings()
    }
    
    

    @IBOutlet weak var gameView: GameView! {
        didSet {
            logVCL("gameView Outlet")
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(GameView.grubPaddle(_:))))
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: gameView, action: #selector(GameView.addBall(_:))))
            //gameView.backgroundColor = UIColor.yellowColor()
        }
    }
    
    private func applaySettings() {
        gameView.bricksBetweenSpacing = CGFloat(BreakOutSettings.breakoutSettings.bricksBetweenSpacing)
        gameView.bricksLine = BreakOutSettings.breakoutSettings.bricksLine
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //logVCL("viewDidLayoutSubviews() GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
        gameView.setInitialPaddlePosition()
        gameView.addMainViewBoundaries()
        gameView.addBricks()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //logVCL("viewDidAppear(animated = \(animated)) GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
        gameView.animating = true
    }   
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //logVCL("viewDidDisappear(animated = \(animated)) GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
        gameView.animating = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //logVCL("viewWillAppear(animated = \(animated)) GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //logVCL("viewWillDisappear(animated = \(animated)) GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //logVCL("viewWillLayoutSubviews() GameView bounds.size = \(gameView.bounds.size) - View bounds.size = \(view.bounds.size)")
    }

}
