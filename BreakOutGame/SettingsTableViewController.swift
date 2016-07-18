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
    }


    @IBOutlet weak var bricksLineNumber: UILabel!
    @IBAction func setBricksLine(sender: UIStepper) {
        let linesNumber = Int(sender.value)
        bricksLineNumber.text = "\(linesNumber)"
        BreakOutSettings.breakoutSettings.bricksLine = linesNumber
    }
    
    
    @IBOutlet weak var spacingBetweenBricks: UILabel!
    @IBAction func setBricksSpacing(sender: UISlider) {
        let value = Int(sender.value)
        spacingBetweenBricks.text = "\(value)"
        //BreakOutSettings.breakoutSettings.bricksBetweenSpacing = value
    }
    
    
    @IBAction func specialBrick(sender: UISwitch) {
    }
    
    

    @IBOutlet weak var balls: UILabel!
    @IBAction func setBallsNumber(sender: UIStepper) {
        let value = Int(sender.value)
        balls.text = "\(value)"
    }
    
    @IBOutlet weak var complexity: UILabel!
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
