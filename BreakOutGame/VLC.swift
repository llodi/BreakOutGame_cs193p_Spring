//
//  VLC.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 17.07.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

var gameMVCinstanceCount = 0
func getGameMVCinstanceCount() -> Int { gameMVCinstanceCount += 1; return gameMVCinstanceCount }
var gameViewinstanceCount = 0
func getGameViewinstanceCount() -> Int { gameViewinstanceCount += 1; return gameViewinstanceCount }

var lastLog = NSDate()
var logPrefix = ""

func bumpLogDepth() {
    if lastLog.timeIntervalSinceNow < -1.0 {
        logPrefix += "__"
        lastLog = NSDate()
    }
}

extension GameView {
    func logVCL(msg: String) {
        bumpLogDepth()
        //let ins = instanceCount
        print("\(logPrefix)Game View " + msg)
    }
}

extension GameViewController {
    func logVCL(msg: String) {
        bumpLogDepth()
        //let ins = instanceCount
        print("\(logPrefix)Game Controller  " + msg)
    }
////
//    override func awakeFromNib() {
//        logVCL("awakeFromNib()")
//    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        logVCL("viewDidLoad()")
//    }
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        logVCL("viewWillAppear(animated = \(animated)) bounds.size = \(view.bounds.size)")
//    }
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        logVCL("viewDidAppear(animated = \(animated))")
//    }
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        logVCL("viewWillDisappear(animated = \(animated)) bounds.size = \(view.bounds.size)")
//    }
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        logVCL("viewDidDisappear(animated = \(animated))")
//    }
//    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
//    }
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//        logVCL("viewWillTransitionToSize")
//        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
//            self.logVCL("animatingAlongsideTransition")
//            }, completion: { context -> Void in
//                self.logVCL("doneAnimatingAlongsideTransition")
//        })
//    }

}

