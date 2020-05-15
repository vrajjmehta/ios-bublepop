//
//  HighScoreScene.swift
//  bubble-pop-lahirurane
//
//  Created by Lahiru Ranasinghe on 1/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLabels()
    }
    
    func addLabels(){
        let highScoreLabel = SKLabelNode(text: "HighScore  ")
        highScoreLabel.name = "highScore"
        highScoreLabel.fontName = "Noteworthy-Bold"
        highScoreLabel.fontSize = 40.0
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - highScoreLabel.frame.size.height*2)
        addChild(highScoreLabel)
        
        let goBackLabel = SKSpriteNode(imageNamed: "backbtn")
        goBackLabel.name = "goBack"
        goBackLabel.position = CGPoint(x: frame.midX, y: frame.minY + goBackLabel.frame.size.height)
        addChild(goBackLabel)
        
        let framePosition = frame.width / 6
        
        let scoreIndexLbl = SKLabelNode(text: "Position")
        scoreIndexLbl.name = "scoreIndexLbl"
        scoreIndexLbl.fontName = "Noteworthy-Bold"
        scoreIndexLbl.fontSize = 20.0
        scoreIndexLbl.fontColor = UIColor.white
        scoreIndexLbl.position = CGPoint(x: framePosition, y: frame.maxY - highScoreLabel.frame.size.height*3 )
        addChild(scoreIndexLbl)
        
        let playerNameLbl = SKLabelNode(text: "Player Name")
        playerNameLbl.name = "playerNameLbl"
        playerNameLbl.fontName = "Noteworthy-Bold"
        playerNameLbl.fontSize = 20.0
        playerNameLbl.fontColor = UIColor.white
        playerNameLbl.position = CGPoint(x: framePosition*3, y: frame.maxY - highScoreLabel.frame.size.height*3 )
        addChild(playerNameLbl)
        
        let scoreLbl = SKLabelNode(text: "Score")
        scoreLbl.name = "playerNameLbl"
        scoreLbl.fontName = "Noteworthy-Bold"
        scoreLbl.fontSize = 20.0
        scoreLbl.fontColor = UIColor.white
        scoreLbl.position = CGPoint(x: framePosition*5, y: frame.maxY - highScoreLabel.frame.size.height*3 )
        addChild(scoreLbl)
        
        let headerYPosition = frame.maxY - highScoreLabel.frame.size.height*4
        //get current string for scoreboard
        let currentScoreBoardObj = UserDefaults.standard.object(forKey: "scoreboard")
        
        if(currentScoreBoardObj != nil){
            
            
            if let decoded = UserDefaults.standard.object(forKey: "scoreboard") as? NSData {
                do {
                let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded as Data) as! [Scoreboard]
                
                
                //                var userScores : [Scoreboard] = array
                let sortedScores = array.sorted(by: { $0.playerScore > $1.playerScore })
                var index = 1
                for score in sortedScores {
                    generateLabelsForScore(index: index, name: score.playerName,score: score.playerScore, headerYPosition: headerYPosition)
                    index += 1
                    
                    if(index > 10){
                        break
                    }
                }
                }catch {
                    print("Error in Loading scoreboard data")
                }
            }
            
        }
        
    }
    
    func generateLabelsForScore(index: Int, name: String, score: Int, headerYPosition: CGFloat){
        let framePosition = frame.width / 6
        let scoreIndexValue = SKLabelNode(text: "\(index)")
        scoreIndexValue.name = "scoreIndexValue_\(index)"
        scoreIndexValue.fontName = "Noteworthy-Bold"
        scoreIndexValue.fontSize = 15.0
        scoreIndexValue.fontColor = UIColor.white
        scoreIndexValue.position = CGPoint(x: framePosition, y: headerYPosition -  CGFloat(Float((index*40))) )
        addChild(scoreIndexValue)
        
        if(index >= 1 && index <= 3){
            let goBackLabel = SKSpriteNode(imageNamed: "medal\(index)")
            goBackLabel.name = "medal\(index)"
            goBackLabel.position = CGPoint(x: framePosition*2, y:headerYPosition -  CGFloat(Float((index*38))))
            addChild(goBackLabel)
        }
        let playerNameValue = SKLabelNode(text: "\(name)")
        playerNameValue.name = "playerNameValue_\(index)"
        playerNameValue.fontName = "Noteworthy-Bold"
        playerNameValue.fontSize = 15.0
        playerNameValue.fontColor = UIColor.white
        playerNameValue.position = CGPoint(x: framePosition*3, y:headerYPosition -  CGFloat(Float((index*40))) )
        addChild(playerNameValue)
        
        let scoreValue = SKLabelNode(text: "\(score)")
        scoreValue.name = "scoreValue_\(index)"
        scoreValue.fontName = "Noteworthy-Bold"
        scoreValue.fontSize = 15.0
        scoreValue.fontColor = UIColor.white
        scoreValue.position = CGPoint(x: framePosition*5, y: headerYPosition -  CGFloat(Float((index*40))) )
        addChild(scoreValue)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "goBack" {
                
                let gameScene = MenuScene(size: view!.bounds.size)
                view!.presentScene(gameScene)
            }
        }
        
        
    }
}
