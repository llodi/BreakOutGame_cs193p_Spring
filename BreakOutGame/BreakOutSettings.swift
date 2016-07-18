//
//  BreakOutSettings.swift
//  BreakOutGame
//
//  Created by Ilya Dolgopolov on 16.07.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import Foundation


class BreakOutSettings {
    
    private struct SettingsKey {
        static let BricksLine = "BreakOutGame.BricksLine"
        static let BricksBetweenSpacing = "BreakOutGame.BricksBetweenSpacing"
        static let SpecialBricks = "BreakOutGame.SpecialBricks"
        static let BallsNumber = "BreakOutGame.BallsNumber"
        static let BallsComplexity = "BreakOutGame.BallsComplexity"
    }
    
    private struct Defaults {
        static let BricksLine: Int = 2
        static let BricksBetweenSpacing: Double = 2.0
        static let SpecialBricks = false
        static let BallsNumber: Int = 1
        static let BallsComplexity: Double = 0.0
    }
    
    static let breakoutSettings = BreakOutSettings()
    
    let defaults = NSUserDefaults.standardUserDefaults
    
    
    var bricksLine: Int {
        get { return defaults().objectForKey(SettingsKey.BricksLine) as? Int ?? Defaults.BricksLine }
        set { defaults().setObject(newValue, forKey: SettingsKey.BricksLine); defaults().synchronize() }
        
    }
    
    var bricksBetweenSpacing: Double {
        get { return defaults().objectForKey(SettingsKey.BricksBetweenSpacing) as? Double ?? Defaults.BricksBetweenSpacing }
        set { defaults().setObject(newValue, forKey: SettingsKey.BricksBetweenSpacing); defaults().synchronize() }
    }
    
    var specialBricks: Bool {
        get { return defaults().objectForKey(SettingsKey.SpecialBricks) as? Bool ?? Defaults.SpecialBricks }
        set { defaults().setObject(newValue, forKey: SettingsKey.SpecialBricks); defaults().synchronize() }
    }
    
    var ballsNumber: Int {
        get { return defaults().objectForKey(SettingsKey.BallsNumber) as? Int ?? Defaults.BallsNumber }
        set { defaults().setObject(newValue, forKey: SettingsKey.BallsNumber); defaults().synchronize() }
    }
    
    var ballsComplexity: Double {
        get { return defaults().objectForKey(SettingsKey.BallsComplexity) as? Double ?? Defaults.BallsComplexity }
        set { defaults().setObject(newValue, forKey: SettingsKey.BallsComplexity); defaults().synchronize() }
    }
    
}