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
        applaySettings()
    }
    
    private var gameStarted = true

    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(GameView.grubPaddle(_:))))
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: gameView, action: #selector(GameView.addBall(_:))))
        }
    }
    
    private func applaySettings() {
        gameView.bricksBetweenSpacing = CGFloat(BreakOutSettings.breakoutSettings.bricksBetweenSpacing)
        gameView.bricksLine = BreakOutSettings.breakoutSettings.bricksLine
        gameView.isSpecialBricks = BreakOutSettings.breakoutSettings.specialBricks
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    private func updateUI() {
        gameView.removeBricks()
        gameView.setInitialPaddlePosition()
        gameView.addMainViewBoundaries()
        gameView.addBricks()
        gameStarted = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
        if gameStarted {
            updateUI()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        gameView.animating = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if BreakOutSettings.isSettingsChanged {
            applaySettings()
            updateUI()
            BreakOutSettings.isSettingsChanged = false
        }
    }

}
