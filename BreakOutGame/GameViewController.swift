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
        
    }

    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(GameView.grubPaddle(_:))))
            //gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(GameView.placePaddle(_:))))
        }
    }

}
