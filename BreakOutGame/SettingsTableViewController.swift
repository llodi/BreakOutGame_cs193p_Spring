//
//  SettingsTableViewController.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 16.07.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initFromSettings()
    }
    
    private func initFromSettings() {
        brickLinesOultet.value = Double(BreakOutSettings.breakoutSettings.bricksLine)
        bricksLineNumber.text = "\(Int(brickLinesOultet.value))"
        betweenSpacingOutlet.value = Float(BreakOutSettings.breakoutSettings.bricksBetweenSpacing)
        spacingBetweenBricks.text = "\(numberFormatter.stringFromNumber(betweenSpacingOutlet.value)!)"
        specialBricksOutlet.on = BreakOutSettings.breakoutSettings.specialBricks
    }

    @IBOutlet weak var brickLinesOultet: UIStepper!
    @IBOutlet weak var bricksLineNumber: UILabel!
    @IBAction func setBricksLine(sender: UIStepper) {
        let linesNumber = Int(sender.value)
        BreakOutSettings.breakoutSettings.bricksLine = linesNumber
        bricksLineNumber.text = "\(linesNumber)"
    }
    
    
    @IBOutlet weak var betweenSpacingOutlet: UISlider!
    @IBOutlet weak var spacingBetweenBricks: UILabel!
    @IBAction func setBricksSpacing(sender: UISlider) {
        let value = Int(sender.value)
        BreakOutSettings.breakoutSettings.bricksBetweenSpacing = value
        spacingBetweenBricks.text = "\(value)"
    }
    
    
    @IBOutlet weak var specialBricksOutlet: UISwitch!
    @IBAction func specialBrick(sender: UISwitch) {
        BreakOutSettings.breakoutSettings.specialBricks = sender.on
    }

    @IBOutlet weak var balls: UILabel!
    @IBOutlet weak var ballsNumberOutlet: UIStepper!
    @IBAction func setBallsNumber(sender: UIStepper) {
        let value = Int(sender.value)
        balls.text = "\(value)"
    }
    
    @IBOutlet weak var complexity: UILabel!
    @IBOutlet weak var complexityOutlet: UISlider!
    @IBAction func ballsComplexity(sender: UISlider) {
        let value = Double(sender.value)
        complexity.text = numberFormatter.stringFromNumber(value)
    }
}

let numberFormatter: NSNumberFormatter = {
    let formatter = NSNumberFormatter()
    formatter.locale = NSLocale.currentLocale()
    formatter.numberStyle = .DecimalStyle
    formatter.maximumFractionDigits = 1
    //formatter.groupingSeparator = " "
    return formatter
}()
