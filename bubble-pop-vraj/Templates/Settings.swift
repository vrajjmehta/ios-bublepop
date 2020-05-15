//
//  Settings.swift
//  bubble-pop-lahirurane
//
//  Created by Lahiru Ranasinghe on 3/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import Foundation

import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1 << 0
    static let poppedBall: UInt32 = 0x1 << 1
}

enum ZPositions{
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let poppedBall: CGFloat = 2
}

enum GameSettings{
    //    static var gameTime: Int = UserDefaults.
    //    static var maximumBalls: Int = 30
    static var username: String = ""
    
}

enum BubbleTypeScore{
    static let Red: Int = 1
    static let Pink: Int = 2
    static let Green: Int = 5
    static let Blue: Int = 8
    static let Black: Int = 10
}



