//
//  Score.swift
//  bubble-pop-lahirurane
//
//  Created by Lahiru Ranasinghe on 6/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import Foundation

// Model struct for the score
class Scoreboard: NSObject, NSCoding  {
    
    
    private var name: String!
    private var score: Int!
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    var playerName: String {
        get {
            return name
        }
        set {
            name = newValue
        }
    }
    
    var playerScore: Int {
        get {
            return score
        }
        set {
            score = newValue
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(score, forKey: "score")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
      
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let score = aDecoder.decodeObject(forKey: "score") as! Int
        self.init(name: name, score: score)
    }
}
