//
//  Bubble.swift
//  bubble-pop-lahirurane
//
//  Created by Lahiru Ranasinghe on 6/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

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
