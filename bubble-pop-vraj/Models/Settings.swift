// --------Important INFO--------------
//This project is programmed using SpriteKit & GamePlayKit
//There are No Standard View Controllers as such, various "Scenes" make up the View Controller
//Also, In Storyboard you wont be able to see different views
//The views are dynamically created using SprikeKit

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

// Defint the score for each bubble based on color
enum BubbleTypeScore{
    static let Red: Int = 1
    static let Pink: Int = 2
    static let Green: Int = 5
    static let Blue: Int = 8
    static let Black: Int = 10
}
