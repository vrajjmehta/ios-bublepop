// --------Important INFO--------------
//This project is programmed using SpriteKit & GamePlayKit
//There are No Standard View Controllers as such, various "Scenes" make up the View Controller
//Also, In Storyboard you wont be able to see different views
//The views are dynamically created using SprikeKit

import Foundation

// Model struct for the Bubble
struct Bubble: Codable {
    var bubbleType: String
    var bubbleImgName: String
    var bubbleValue: Int
    
    init(bubbleType: String, bubbleValue: Int, bubbleImgName: String) {
        self.bubbleType = bubbleType
        self.bubbleValue = bubbleValue
        self.bubbleImgName = bubbleImgName
    }
    
    func getBubbleType() -> String{
        return self.bubbleType
    }
    
    func getBubbleValue() -> Int{
        return self.bubbleValue
    }
    
    func getBubbleImgName() -> String{
        return self.bubbleImgName
    }
    
    mutating func setBubbleImgName(bubbleImgName: String) {
        self.bubbleImgName = bubbleImgName
    }
    
    mutating func setBubbleType(bubbleType: String) {
        self.bubbleType = bubbleType
    }
    
    mutating func setBubbleValue(bubbleValue: Int){
        self.bubbleValue = bubbleValue
    }
}
